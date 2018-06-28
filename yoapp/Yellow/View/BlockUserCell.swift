//
//  BlockUserCell.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit


class BlockUserCell: UITableViewCell {
    
    var separatorView = UIView()
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.layer.borderColor = UIColor(hexString: "E36980").cgColor
        image.layer.borderWidth = 2
        return image
    }()
    
    let nameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 16, fontType: .mySemiBold)
    let phoneLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 14, fontType: .myRegular)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        setupViews()
    }
    
    func setupViews(){
        self.addSubview(separatorView)
        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(phoneLabel)
        
        separatorView.backgroundColor = UIColor(hexString: "FED88B")
        separatorView.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top)
            make.left.right.equalTo(0)
            make.height.equalTo(1)
        }
        
        profileImage.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.width.height.equalTo(50)
            make.left.equalTo(self.snp.left).offset(24)
        }
        
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(21)
            make.left.equalTo(profileImage.snp.right).offset(20)
        }
        
        phoneLabel.snp.makeConstraints{(make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel)
        }
    }
    
    func data(image: UIImage, name: String,phone: String){
        profileImage.image = image
        nameLabel.text = name
        phoneLabel.text = phone
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
