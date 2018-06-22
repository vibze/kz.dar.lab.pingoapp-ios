//
//  ProfileTableViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//
import UIKit

class ProfileTableViewController: UITableViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let headerView =  ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 230))
    let footerView = InviteFriendsView(frame: CGRect(x: 0, y: 0, width: 307, height: 105))
    let imagePicker = UIImagePickerController()
    var profileCell = "profileCell"
    var settingsType = ["Настройки","О приложении","Выход"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        viewData()
    }
    
    func configTableView(){
        tableView.backgroundColor = UIColor(hexString: "FEC95F")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 50
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
        cell.backgroundColor = .clear
        cell.settingLabel.text = settingsType[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openViewController(viewController: SettingViewController())
        case 1:
            openViewController(viewController: AboutAppViewController())
        case 2:
            openViewController(viewController: AuthViewController())
        default:
            break
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        headerView.profileImg.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func openViewController(viewController: UIViewController){
        let vc = viewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
