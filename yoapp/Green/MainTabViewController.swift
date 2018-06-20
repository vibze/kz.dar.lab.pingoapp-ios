//
//  MainTabViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/19/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MainTabViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let contactsBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "chaticon"), for: .normal)
        btn.tag = 0
        btn.addTarget(self, action: #selector(tabBarBtnPressed), for: .touchUpInside)

        return btn
    }()
    
    let homeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "homeicon"), for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(tabBarBtnPressed), for: .touchUpInside)

        return btn
    }()
    
    let settingsBtn: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setImage(#imageLiteral(resourceName: "profileIcon"), for: .normal)
        btn.addTarget(self, action: #selector(tabBarBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    let activeImg = [#imageLiteral(resourceName: "chatInicon"), #imageLiteral(resourceName: "homeInicon"), #imageLiteral(resourceName: "profileInicon")]
    let inactiveImg = [#imageLiteral(resourceName: "chaticon"), #imageLiteral(resourceName: "homeicon"), #imageLiteral(resourceName: "profileIcon"),]
    let controllers = [MyContactsViewController(), ContactsViewController(), SettingsViewController()]
    
    @objc func tabBarBtnPressed(sender: UIButton) {
        [settingsBtn, homeBtn, contactsBtn].forEach { (btn) in
            btn.setImage(inactiveImg[btn.tag], for: .normal)
        }
        sender.setImage(activeImg[sender.tag], for: .normal)
        self.view.layoutSubviews()
        
        let controller = controllers[sender.tag]
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let controller = ContactsViewController()
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        homeBtn.setImage(activeImg[1], for: .normal)
        
        controller.didMove(toParentViewController: self)

    }
    
    func setupViews() {
        [containerView, homeBtn, settingsBtn, contactsBtn].forEach { (newView) in
            view.addSubview(newView)
        }
        containerView.snp.makeConstraints { (constraint) in
            constraint.top.bottom.right.left.equalTo(0)
        }
        contactsBtn.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(0)
            constraint.bottom.equalTo(-10)
            constraint.height.equalTo(60)
            constraint.width.equalTo(self.view.frame.width / 3)
        }
        homeBtn.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(contactsBtn.snp.right)
            constraint.bottom.equalTo(-10)
            constraint.height.equalTo(60)
            constraint.width.equalTo(self.view.frame.width / 3)
        }
        settingsBtn.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(homeBtn.snp.right)
            constraint.bottom.equalTo(-10)
            constraint.height.equalTo(60)
            constraint.width.equalTo(self.view.frame.width / 3)
        }
    }
}
