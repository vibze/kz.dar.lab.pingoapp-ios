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
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "ProximaNovaSoft-Medium", size: 14)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        self.addSubview(nameLabel)
        self.addSubview(iconImage)
        
        iconImage.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(20)
            make.left.equalTo(40)
            make.right.equalTo(-40)
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

