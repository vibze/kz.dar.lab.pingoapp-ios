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
            if screenBounds.height == 568 {
                make.top.equalToSuperview().offset(0)
                make.centerX.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(32)
                make.centerX.equalToSuperview()
            }
        }
        
        backStackView.snp.makeConstraints{
            $0.top.equalTo(friendLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
            if screenHeight == 568 {
                $0.bottom.equalToSuperview().offset(-4)
            } else {
                $0.bottom.equalToSuperview().offset(32)
            }
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(4)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalToSuperview().offset(-4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        stackViewConfig()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        telegramView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        whatsUpView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }
    
    func stackViewConfig(){
        telegramView.viewData(icon: #imageLiteral(resourceName: "telegramIcon"), name: "Telegram")
        whatsUpView.viewData(icon: #imageLiteral(resourceName: "whatsAppIcon"), name: "Whatapp")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.isUserInteractionEnabled = true
        
        stackView.addArrangedSubview(telegramView)
        stackView.addArrangedSubview(whatsUpView)
        
        telegramView.translatesAutoresizingMaskIntoConstraints = false
        whatsUpView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

