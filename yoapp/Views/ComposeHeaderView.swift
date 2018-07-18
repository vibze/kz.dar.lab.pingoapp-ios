//
//  ComposeHeaderView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 16.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ComposeHeaderView: UIView {
    
    var backgorunCircle: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.631372549, blue: 0.4784313725, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 55
        return view
    }()
    
    let profileImg = ImageView()
    let profileNameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 20, fontType: FontType.myRegular)
    let phoneNumberLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 20, fontType: FontType.myRegular)
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        self.addSubview(backgorunCircle)
        self.addSubview(profileImg)
        self.addSubview(profileNameLabel)
        self.addSubview(phoneNumberLabel)
        
        backgorunCircle.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(110)
        }
        
        profileImg.snp.makeConstraints{(make) in
            make.top.equalTo(backgorunCircle.snp.top).offset(5)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        profileNameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(profileImg.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints{
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(3)
            $0.left.right.equalTo(profileNameLabel)
        }
    }
    
    func viewData(image: String, phoneNumber: String, profileName: String) {
        profileNameLabel.text = profileName
        phoneNumberLabel.text = "+\(phoneNumber)"
        profileImg.setContactImage(url: image)
    }
}
