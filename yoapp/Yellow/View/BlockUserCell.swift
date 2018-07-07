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
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.layer.borderColor = #colorLiteral(red: 0.8901960784, green: 0.4117647059, blue: 0.5019607843, alpha: 1).cgColor
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
        
        separatorView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8470588235, blue: 0.5450980392, alpha: 1)
        separatorView.snp.makeConstraints{
            $0.left.right.equalTo(0)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.size.equalTo(50)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(self.snp.top).offset(21)
            $0.left.equalTo(profileImage.snp.right).offset(20)
        }
        
        phoneLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.left.equalTo(nameLabel)
        }
    }
    
    func viewData(image: String, name: String,phone: String){
        profileImage.setCustomImage(Urls.shortUrl + image, custom: #imageLiteral(resourceName: "contactPlaceholder"))
        nameLabel.text = name
        phoneLabel.text = "+\(phone)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
