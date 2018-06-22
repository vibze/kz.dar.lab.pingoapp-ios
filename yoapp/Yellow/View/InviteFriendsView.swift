//
//  InviteFriendsView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class InviteFriendsView : UIView {
    
    var friendLabel: UILabel = {
        let label = UILabel()
        label.textColor = .myPurple
        label.font = UIFont(name: "ProximaNovaSoft-Bold", size: 16)
        label.text = "Пригласить друзей в Ping App"
        return label
    }()
    
    var telegramView: CustomInviteView = {
        let view = CustomInviteView()
        view.backgroundColor = .myPurple
        return view
    }()
    
    var whatsUpView: CustomInviteView = {
        let view = CustomInviteView()
        view.backgroundColor = .myPurple
        return view
    }()
    
    var messengerView: CustomInviteView = {
        let view = CustomInviteView()
        view.backgroundColor = .myPurple
        return view
    }()
    
    var backStackView: UIView = {
        let view = UIView()
        view.backgroundColor = .myOrange
        view.layer.cornerRadius = 10
        return view
    }()
    
    let  stackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.addSubview(friendLabel)
        self.addSubview(backStackView)
        backStackView.addSubview(stackView)
        
        friendLabel.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        backStackView.snp.makeConstraints{
            $0.top.equalTo(friendLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(27)
            $0.right.equalToSuperview().offset(-27)
            $0.bottom.equalToSuperview().offset(30)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        stackViewConfig()
    }
    
    func stackViewConfig(){
        telegramView.viewData(icon: #imageLiteral(resourceName: "telegramIcon"), name: "Telegram")
        whatsUpView.viewData(icon: #imageLiteral(resourceName: "whatsAppIcon"), name: "Whatapp")
        messengerView.viewData(icon: #imageLiteral(resourceName: "messengerIcon"), name: "Messenger")
        
        telegramView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        messengerView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 1
        
        stackView.addArrangedSubview(telegramView)
        stackView.addArrangedSubview(whatsUpView)
        stackView.addArrangedSubview(messengerView)
        
        telegramView.translatesAutoresizingMaskIntoConstraints = false
        whatsUpView.translatesAutoresizingMaskIntoConstraints = false
        messengerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

