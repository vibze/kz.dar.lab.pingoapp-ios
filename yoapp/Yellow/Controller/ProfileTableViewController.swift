//
//  ProfileTableViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//
import UIKit
import Alamofire
import AccountKit
import SwiftyJSON

class ProfileTableViewController: UITableViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    let footerView = ProfileFooterView(frame: CGRect(x: 0, y: 0, width: 307, height: 105))
    let imagePicker = UIImagePickerController()
    var profileCell = "profileCell"
    var settingsType = ["Настройки","О приложении","Выход"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTableView()
        viewData()
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageProfile))
        imagePicker.delegate = self
        
        headerView.profileImg.addGestureRecognizer(tapGestureRecognizer)
        headerView.nameLabel.text = "Kamila Kusainova"
    }
    
    @objc func addImageProfile(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
            openViewController(viewController: LoginViewController())
        default:
            break
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let avatarImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        headerView.profileImg.image = avatarImage
        uploadImage(avatar: avatarImage, success: { response in
            debugPrint("OKKK", response)
        }) { (error) in
            debugPrint("Bad ERror... \(error)")
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func uploadImage(avatar: UIImage, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void){
        guard
            let imageData = UIImageJPEGRepresentation(avatar, 1.0),
            let url = URL(string: "http://178.62.123.161/api/v1/profile/avatar") else {
            debugPrint("Error ")
            return
        }
        
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Authorization": "Bearer \(Token.shared.accessToken!.tokenString)",
                      "Accept":"application/json"]
        
        Alamofire.upload(multipartFormData: { data in
            data.append(imageData, withName: "file", fileName: "myImage.png", mimeType: "image/png")
        }, to: url, method: .post, headers: header) { result in
            switch result {
            case .success(request: let uploadRequest, streamingFromDisk: _, streamFileURL: _):
                uploadRequest.validate(statusCode: 200..<600).responseJSON(completionHandler: {dataResponse in
                    if dataResponse.result.isSuccess {
                        let json = JSON(dataResponse.result.value)
//                        success(dataResponse.result.value)
                        
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
}
