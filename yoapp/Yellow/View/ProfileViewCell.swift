//
//  ProfileViewCell.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {
   
    let settingButton = ActionButton(title: "Настройки", type: .setting)
    let aboutAppButton = ActionButton(title: "О приложении", type: .setting)
    let exitButton = ActionButton(title: "Выход", type: .exit)
    
    let settingLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 18, fontType: .mySemiBold)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        setUpView()
    }
    
    func setUpView(){
        self.addSubview(settingButton)
        self.addSubview(aboutAppButton)
        self.addSubview(exitButton)
        settingButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        aboutAppButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        exitButton.setTitleColor(#colorLiteral(red: 0.6117647059, green: 0.2705882353, blue: 0.4470588235, alpha: 1), for: .normal)
        
        settingButton.snp.makeConstraints{
            if screenBounds.height < 670{
                $0.top.equalToSuperview().offset(0)
            }
            if screenBounds.height == 568{
                $0.height.equalTo(45)
            }
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
            $0.height.equalTo(50)
        }
        
        aboutAppButton.snp.makeConstraints{
            if screenBounds.height == 568{
                $0.top.equalTo(settingButton.snp.bottom).offset(10)
            }
            $0.top.equalTo(settingButton.snp.bottom).offset(20)
            $0.left.right.height.equalTo(settingButton)
        }
        
        exitButton.snp.makeConstraints{
            if screenBounds.height == 568{
                $0.top.equalTo(aboutAppButton.snp.bottom).offset(10)
            }
            $0.top.equalTo(aboutAppButton.snp.bottom).offset(20)
            $0.left.right.height.equalTo(settingButton)
            $0.bottom.equalTo(self).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
