
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
//        fetchAllProfile()
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
        headerView.phoneNumberLabel.text = "+7701-48-49-741"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageProfile))
        headerView.profileImg.addGestureRecognizer(tapGestureRecognizer)
    }
}


extension ProfileTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as! ProfileViewCell
        cell.settingLabel.text = settingsType[indexPath.row]
        if indexPath.row == 2{
            cell.backView.layer.borderColor = UIColor.myPurple.withAlphaComponent(0.5).cgColor
            cell.settingLabel.textColor = .myPurple
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openViewController(viewController: SettingViewController())
        case 1:
            openViewController(viewController: AboutAppViewController())
        case 2:
            Application.shared.logout()
        default:
            break
        }
    }
    
    func touchDetect(){
        let openTelegramGesture = UITapGestureRecognizer(target: self, action: #selector(openTelegram))
        footerView.telegramView.addGestureRecognizer(openTelegramGesture)
        let openWhatsAppGesture = UITapGestureRecognizer(target: self, action: #selector(openWhatsApp))
        footerView.whatsUpView.addGestureRecognizer(openWhatsAppGesture)
        let openMessengerGesture = UITapGestureRecognizer(target: self, action: #selector(openMessenger))
        footerView.messengerView.addGestureRecognizer(openMessengerGesture)
    }
    
    @objc func openTelegram(){
        openMessengerView(urlApp: "tg://msg?text=")
    }
    
    @objc func openWhatsApp(){
        openMessengerView(urlApp: "whatsapp://send?text=")
    }
 
    @objc func openMessenger(){
        openMessengerView(urlApp: "fb-messenger:/user/")
    }
    
    func openMessengerView(urlApp: String){
        let msg = "Install YoApp"
        let urlWhats = urlApp + msg
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    showAlert(errorType: "У вас не установленно это приложение", image: #imageLiteral(resourceName: "errorIcon"))
                }
            }
        }
    }
    
    @objc func addImageProfile(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Сменить фото", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler:
            { (action:UIAlertAction) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true, completion: nil)
                }else{
                    self.showAlert(errorType: "У вас недоступна камера", image: #imageLiteral(resourceName: "errorIcon"))
                }
        }))
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (action:UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let avatarImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        headerView.profileImg.image = avatarImage
        uploadImage(avatar: avatarImage, success: { response in
            print("OKKK", response)
        }) { (error) in
            print("Bad ERror... \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(avatar: UIImage, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void){
        guard
            let imageData = UIImageJPEGRepresentation(avatar, 1.0),
            let url = URL(string: "http://178.62.123.161/api/v1/profile/avatar") else {
                return
        }
        
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Authorization": "Bearer \(Token.shared.accessToken)",
            "Accept":"application/json"]
        print(Token.shared.accessToken)
        
        Alamofire.upload(multipartFormData: { data in
            data.append(imageData, withName: "file", fileName: "myImage.png", mimeType: "image/png")
        }, to: url, method: .post, headers: header) { result in
            switch result {
            case .success(request: let uploadRequest, _, _):
                uploadRequest.validate(statusCode: 200..<600).responseJSON(completionHandler: {dataResponse in
                    if dataResponse.result.isSuccess {
                        print(dataResponse, "RESPONSE!!")
                        let statusCode = dataResponse.response!.statusCode
                        self.handleError(with: statusCode)
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
    
    func fetchAllProfile(){
        CoreStore.perform(
            asynchronous: { (transaction) -> Void in
                let person = transaction.fetchAll(From<Contact>().where(\.profileId == 0))
                for some in person! {
                    print(some.phoneNumber!, "Phone Number")
                }
        },
            completion: { _ in }
        )
    }
}
