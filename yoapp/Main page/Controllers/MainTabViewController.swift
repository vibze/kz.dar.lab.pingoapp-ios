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
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let contactsButton = TabBarButton(tag: 0, type: .contacts)
    let homeButton = TabBarButton(tag: 1, type: .home)
    let profileButton = TabBarButton(tag: 2, type: .profile)
    
    let activeImg = [#imageLiteral(resourceName: "contactsSelected"), #imageLiteral(resourceName: "homeSelected"), #imageLiteral(resourceName: "profileSelected")]
    let inactiveImg = [#imageLiteral(resourceName: "contacts"), #imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "profile"),]
    let controllers = [MyContactsViewController(), ContactsViewController(), ProfileTableViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
        moveToViewController(index: 1)
    }
    
    @objc func tabBarBtnPressed(sender: UIButton) {
        [profileButton, contactsButton, homeButton].forEach {
            $0.setImage(inactiveImg[$0.tag], for: .normal)
        }
        sender.setImage(activeImg[sender.tag], for: .normal)
        moveToViewController(index: sender.tag)
    }
    
    func moveToViewController(index: Int) {
        let controller = controllers[index]
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        controller.view.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setupButtons() {
        [contactsButton, homeButton, profileButton].forEach {
            $0.addTarget(self, action: #selector(tabBarBtnPressed), for: .touchUpInside)
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupViews() {
        [containerView, homeButton, profileButton, contactsButton, stackView].forEach {
            view.addSubview($0)
        }
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(24)
        }
    }
}
