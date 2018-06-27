//
//  CheckLoginViewController.swift
//  yoapp
//
//  Created by Arthur Belyankov on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import AccountKit

fileprivate func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default: return rhs < lhs
    }
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

class CheckLoginViewController: UIViewController {
    
    var accountKit: AKFAccountKit!
    
    let accountID: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let phoneLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let logOutBotton = ActionButton(title: "logout", type: .rgstr)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupView()
        if accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: .accessToken)
            accountKit.requestAccount({ (account, error) in
                self.accountID.text = account?.accountID
                if account?.phoneNumber?.phoneNumber != nil {
                    self.phoneLabel.text = account!.phoneNumber?.stringRepresentation()
                    self.logOutBotton.addTarget(self, action: #selector(self.logOutBtnPressed), for: .touchUpInside)
                }
                }
            )
        }
    }
    
    func setupView(){
        view.addSubview(accountID)
        view.addSubview(phoneLabel)
        view.addSubview(logOutBotton)
        
        accountID.snp.makeConstraints{
            $0.top.equalTo(50)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
        }
        
        phoneLabel.snp.makeConstraints{
            $0.top.equalTo(120)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
        }
        
        logOutBotton.snp.makeConstraints{
            $0.top.equalTo(170)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func logOutBtnPressed() {
        accountKit.logOut()
        dismiss(animated: true, completion: nil)
        print("log out")
    }
}
