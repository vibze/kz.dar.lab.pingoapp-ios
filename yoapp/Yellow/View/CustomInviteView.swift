//
//  CustomInviteView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class CustomInviteView: UIView {
    
    var iconImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let nameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 14, fontType: .mySemiBold)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .myPurple
        setUpViews()
    }
    
    func setUpViews() {
        self.addSubview(nameLabel)
        self.addSubview(iconImage)
        
        iconImage.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(7)
            make.height.width.equalTo(20)
            make.centerX.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(iconImage.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    func viewData(icon: UIImage,name: String){
        iconImage.image = icon
        nameLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

