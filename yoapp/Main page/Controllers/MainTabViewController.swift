//
//  MainTabViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/19/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MainTabViewController: UIViewController {
    
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

    let stackViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effect
    }()
    
    let contactsButton = TabBarButton(tag: 0, image: #imageLiteral(resourceName: "contacts"))
    let homeButton = TabBarButton(tag: 1, image:  #imageLiteral(resourceName: "home"))
    let profileButton = TabBarButton(tag: 2, image: #imageLiteral(resourceName: "profile"))

    let controllers = [MyContactsViewController(), ContactsViewController(), ProfileTableViewController()]
    let vcBackgroundColors = [#colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.7882352941, blue: 0.3725490196, alpha: 1)]
    let stackViewHidden = [false, false, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
        tabBarBtnPressed(sender: homeButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        controller.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.backgroundColor = vcBackgroundColors[index]
        blurEffectView.isHidden = stackViewHidden[index]
    }
    
    func setupButtons() {
        [contactsButton, homeButton, profileButton].forEach {
            $0.addTarget(self, action: #selector(tabBarBtnPressed), for: .touchUpInside)
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupViews() {
        [containerView, homeButton, profileButton, contactsButton, stackViewBackground, stackView].forEach {
            view.addSubview($0)
        }
        
        stackViewBackground.addSubview(blurEffectView)
        
        stackViewBackground.snp.makeConstraints {
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview()
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
