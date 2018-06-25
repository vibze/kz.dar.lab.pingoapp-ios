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
    
    let contactsButton = TabBarButton(tag: 0, image: #imageLiteral(resourceName: "contacts"))
    let homeButton = TabBarButton(tag: 1, image:  #imageLiteral(resourceName: "home"))
    let profileButton = TabBarButton(tag: 2, image: #imageLiteral(resourceName: "profile"))
    
//    let activeImg = [#imageLiteral(resourceName: "contactsSelected"), #imageLiteral(resourceName: "homeSelected"), #imageLiteral(resourceName: "profileSelected")]
//    let inactiveImg = [#imageLiteral(resourceName: "contacts"), #imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "profile")]
    let controllers = [MyContactsViewController(), ContactsViewController(), ProfileTableViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        moveToViewController(index: 1)
        homeButton.isSelected = true
    }
    
    @objc func tabBarBtnPressed(sender: TabBarButton) {
        moveToViewController(index: sender.tag)
        [profileButton, contactsButton, homeButton].forEach {
            $0.isSelected = false
        }
        sender.isSelected = true
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
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(24)
        }
    }
}
