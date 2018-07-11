//
//  ProfileHeaderView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var backgorunCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .myYellow
        view.clipsToBounds = true
        view.layer.cornerRadius = 55
        return view
    }()
    
    var profileImg: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 50
        image.layer.borderColor = UIColor.myOrange.cgColor
        image.layer.borderWidth = 4
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myYellow
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.font = UIFont(name: FontType.myBold.rawValue, size: 20)
        return label
    }()
    
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
        
        phoneNumberLabel.snp.makeConstraints{(make) in
            make.top.equalTo(profileImg.snp.bottom).offset(16)
            make.left.equalTo(79)
            make.right.equalTo(-79)
            make.height.equalTo(40)
        }
        
    }
    
    func viewData(image: String,phoneNumber: String){
        phoneNumberLabel.text = "+\(phoneNumber)"
        profileImg.setCustomImage("http://178.62.123.161" + image, custom: #imageLiteral(resourceName: "cameraPhoto"))
    }
}

