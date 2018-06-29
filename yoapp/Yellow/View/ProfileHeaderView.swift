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
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myYellow
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.font = UIFont(name: "ProximaNovaSoft-Bold", size: 20)
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
        self.addSubview(nameLabel)
        
        backgorunCircle.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalTo(self)
            make.width.height.equalTo(110)
        }
        
        profileImg.snp.makeConstraints{(make) in
            make.top.equalTo(backgorunCircle.snp.top).offset(5)
            make.width.height.equalTo(100)
            make.centerX.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(profileImg.snp.bottom).offset(16)
            make.left.equalTo(79)
            make.right.equalTo(-79)
            make.height.equalTo(40)
        }
        
        if profileImg.image != nil {
            print("Nil")
            let data = UserDefaults.standard.object(forKey: "profileImage")
            profileImg.image = UIImage(data: data as! Data)
        }else{
            profileImg.image = #imageLiteral(resourceName: "cameraPhoto")
        }
    }
}

