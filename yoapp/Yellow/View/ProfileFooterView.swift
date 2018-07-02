//
//  InviteFriendsView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ProfileFooterView : UIView {
    
    var friendLabel = UILabel.basic(textColor: .myPurple, fontSize: 16, fontType: .mySemiBold)
    
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
        friendLabel.text = "Пригласить друзей в Ping App"
        
        friendLabel.snp.makeConstraints{(make) in
            if screenBounds.height == 568{
                make.top.equalToSuperview().offset(0)
                make.centerX.equalToSuperview()
            }else{
                make.top.equalToSuperview().offset(30)
                make.centerX.equalToSuperview()
            }
        }
        
        backStackView.snp.makeConstraints{
            $0.top.equalTo(friendLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(27)
            $0.right.equalToSuperview().offset(-27)
            if screenBounds.height == 568{
                $0.bottom.equalToSuperview().offset(-5)
            }else{
                $0.bottom.equalToSuperview().offset(30)
            }
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        stackViewConfig()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        telegramView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        messengerView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }
    
    func stackViewConfig(){
        telegramView.viewData(icon: #imageLiteral(resourceName: "telegramIcon"), name: "Telegram")
        whatsUpView.viewData(icon: #imageLiteral(resourceName: "whatsAppIcon"), name: "Whatapp")
        messengerView.viewData(icon: #imageLiteral(resourceName: "messengerIcon"), name: "Messenger")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.isUserInteractionEnabled = true
        
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

