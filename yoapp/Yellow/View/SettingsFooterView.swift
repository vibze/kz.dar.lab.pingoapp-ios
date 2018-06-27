//
//  SettingsFooterView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SettingsFooterView: UIView {
    
    let notificationLabel = UILabel.basic(textColor: .myPurple, fontSize: 20)
    
    var notificationSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.backgroundColor = .myPurple
        switcher.layer.cornerRadius = 20
        switcher.thumbTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switcher.layer.borderColor = UIColor.white.cgColor
        return switcher
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(notificationLabel)
        self.addSubview(notificationSwitcher)
        setUpView()
    }
    
    func setUpView(){
        notificationLabel.text = "Отлючить уведомления"
        
        notificationLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
        
        notificationSwitcher.snp.makeConstraints{
            $0.top.equalTo(notificationLabel)
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
