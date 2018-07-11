
//  ProfileTableViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import CoreStore

class ProfileTableViewController: UITableViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    let footerView = ProfileFooterView(frame: CGRect(x: 0, y: 0, width: 307, height: 105))
    var profileCell = "profileCell"
    var settingsType = ["Настройки","О приложении","Выход"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTableView()
        viewData()
        touchDetect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func configTableView(){
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(ProfileViewCell.self, forCellReuseIdentifier: profileCell)
    }
    
    func viewData(){
        let phoneNumber = Profile.current()?.phoneNumber
        let profileImage = Profile.current()?.avatarImageUrl
        headerView.viewData(image: profileImage!, phoneNumber: phoneNumber!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageProfile))
        headerView.profileImg.addGestureRecognizer(tapGestureRecognizer)
    }
}


extension ProfileTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as! ProfileViewCell
        cell.settingButton.addTarget(self, action: #selector(openSettingVC), for: .touchUpInside)
        cell.aboutAppButton.addTarget(self, action: #selector(openAboutVC), for: .touchUpInside)
        cell.exitButton.addTarget(self, action: #selector(openExitVC), for: .touchUpInside)
        return cell
    }
    
    @objc func openSettingVC(){
        openViewController(viewController: SettingViewController())
    }
    
    @objc func openAboutVC(){
        openViewController(viewController: AboutAppViewController())
    }
    
    @objc func openExitVC(){
        Application.shared.logout()
    }
    
    func touchDetect(){
        let openTelegramGesture = UITapGestureRecognizer(target: self, action: #selector(openTelegram))
        footerView.telegramView.addGestureRecognizer(openTelegramGesture)
        let openWhatsAppGesture = UITapGestureRecognizer(target: self, action: #selector(openWhatsApp))
        footerView.whatsUpView.addGestureRecognizer(openWhatsAppGesture)
    }
    
    @objc func openTelegram(){
        openMessengerView(urlApp: "tg://msg?text=")
    }
    
    @objc func openWhatsApp(){
        openMessengerView(urlApp: "whatsapp://send?text=")
    }
    
    func openMessengerView(urlApp: String){
        let msg = "Install YoApp"
        let urlWhats = urlApp + msg
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                guard UIApplication.shared.canOpenURL(whatsappURL as URL) else{
                    showAlert(errorType: "У вас не установленно это приложение", image: #imageLiteral(resourceName: "errorIcon"))
                    return
                }
                UIApplication.shared.openURL(whatsappURL as URL)
            }
        }
    }
}
extension ProfileTableViewController{
     // MARK: - Image properties
    
    @objc func addImageProfile(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Сменить фото", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler:
            { (action:UIAlertAction) in
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
                    self.showAlert(errorType: "У вас недоступна камера", image: #imageLiteral(resourceName: "errorIcon"))
                    return
                }
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Фотопленка", style: .default, handler: { (action:UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let avatarImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        headerView.profileImg.image = avatarImage
        uploadImage(avatar: fixOrientation(img: avatarImage), success: { response in
            print("OKKK", response)
        }) { (error) in
            self.showAlert(errorType: "Ошибка при загрузки фото", image: #imageLiteral(resourceName: "errorIcon"))
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(avatar: UIImage, success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void){
        guard
            let imageData = UIImageJPEGRepresentation(avatar,1.0),
            let url = URL(string: Urls.getUrl(.avatarUpload)) else {
                return
        }
        let token = UserDefaults().getAccessToken()
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Authorization": "Bearer \(token)",
            "Accept":"application/json"]
        
        Alamofire.upload(multipartFormData: { data in
            data.append(imageData, withName: "file", fileName: "myImage.png", mimeType: "image/png")
        }, to: url, method: .post, headers: header) { result in
            switch result {
            case .success(request: let uploadRequest, _, _):
                uploadRequest.validate(statusCode: 200..<600).responseJSON(completionHandler: {dataResponse in
                    if dataResponse.result.isSuccess {
                        success(dataResponse.result.isSuccess)
                    } else {
                        guard let error = dataResponse.error else { return }
                        failure(error)
                    }
                })
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
}
