//
//  RegistrationDescriptionView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 16.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class RegistrationDescriptionView: UIView {
    
    let smallBubbleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "login_screen_small_bubble")
        return iv
    }()
    
    let nameApp = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 24, fontType: FontType.myBold)
    
    let bigBubbleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Oval")
        return iv
    }()
    
    let descriptionLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 12, fontType: FontType.myRegular)
    
    let biggestOvalImageView: UIImageView = {
        let ov = UIImageView()
        ov.image = #imageLiteral(resourceName: "Oval 2")
        return ov
    }()
    
    let bigOvalImageView: UIImageView = {
        let ov = UIImageView()
        ov.image = #imageLiteral(resourceName: "Oval 2 Copy")
        return ov
    }()
    
    let smallOvalImageView: UIImageView = {
        let ov = UIImageView()
        ov.image = #imageLiteral(resourceName: "Oval 2 Copy 2")
        return ov
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [smallBubbleImageView,nameApp,bigBubbleImageView,descriptionLabel,
         biggestOvalImageView,bigOvalImageView,smallOvalImageView]
        .forEach{self.addSubview($0)}
        setUpView()
    }
    
    func setUpView(){
        nameApp.text = "Pingo App"
        descriptionLabel.text = "Регистрируйтесь,\nприглашайте друзей и начните \nотправлять уведомления уже сейчас!"
        
        nameApp.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        smallBubbleImageView.snp.makeConstraints {
            $0.center.equalTo(nameApp)
            $0.edges.equalTo(nameApp).inset(UIEdgeInsets(top: 0, left: -20, bottom: 0, right: -15))
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameApp.snp.bottom).offset(20)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
        }
        
        bigBubbleImageView.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel).offset(-3)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
        }
        
        biggestOvalImageView.snp.makeConstraints{
            $0.top.equalTo(bigBubbleImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        bigOvalImageView.snp.makeConstraints{
            $0.top.equalTo(biggestOvalImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        smallOvalImageView.snp.makeConstraints{
            $0.top.equalTo(bigOvalImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
