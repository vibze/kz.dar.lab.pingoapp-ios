//
//  AppDelegate.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/17/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreData
import CoreStore
import UserNotifications
import AccountKit

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.window = window
        window.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().delegate = self
        
        Store.initCoreStore()
        
        checkStorage()
        return true
    }
    
    func checkStorage() {
        if let profile = Profile.current() {
            Application.shared.login(profile: profile)
        } else {
            Application.shared.logout()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        debugPrint("APNs device token: \(deviceTokenString)")
        ProfileApi().uploadDeviceToken(deviceToken: deviceTokenString, success: { _ in }, failure: { _ in })
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("APNs registration failed: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent: UNNotification,
                                withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
        
//        if UserDefaults.standard.bool(forKey: "turnOffNotification") {
            withCompletionHandler([.alert])
//        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler: @escaping ()-> ()) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier: // "com.apple.UNNotificationDefaultActionIdentifier"
            openSenderProfile()
        default:
            withCompletionHandler()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("OK")
        if !UserDefaults.standard.bool(forKey: "turnOffNotification") {
            if let aps = userInfo["aps"] as? [String: AnyObject],
                let text = aps["alert"] as? String {
                print(aps)
                SpeechSynthesizer.speak(text)
            }
        }

        switch application.applicationState {
        case .active:
            completionHandler(.noData)
        case .background:
            openSenderProfile()
            completionHandler(.newData)
        case .inactive:
            openSenderProfile()
            completionHandler(.newData)
        }
    }
    
    func openSenderProfile(){
        let vc = MainTabViewController()
        let rootVC = UINavigationController(rootViewController: vc)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = rootVC
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if Profile.current() != nil {
            ContactsService().syncContacts()
        }
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(self.removeNotification),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func removeNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


class Application {
    
    static let shared = Application()
    
    var window: UIWindow?
    
    func login(profile: Profile) {
        Profile.addToUserDefaults(profile)
        let vc = UINavigationController(rootViewController: MainTabViewController())
        window?.rootViewController = vc
        registerForRemoteNotification()
        ContactsService().syncContacts()
        Store.addDefaultPhrases()
        UserDefaults.standard.set(false, forKey: "turnOffNotification")
    }
    
    func logout() {
        AKFAccountKit(responseType: .accessToken).logOut()
        window?.rootViewController = LoginViewController()
    }
    
    private func registerForRemoteNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            }
        }
    }
}
