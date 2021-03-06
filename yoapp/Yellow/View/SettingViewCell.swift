//
//  SettingViewCell.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SettingViewCell: UITableViewCell {
    
    let separateView1 = UIView()
    var labelName = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 18, fontType: .myRegular)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        self.backgroundColor = .myYellow
        self.addSubview(separateView1)
        self.addSubview(labelName)
        
        setUpView()
    }
    
    func setUpView(){
        separateView1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        separateView1.snp.makeConstraints{
            $0.top.left.right.equalToSuperview().offset(0)
            $0.height.equalTo(1)
        }
        
        labelName.snp.makeConstraints{
            $0.top.equalTo(separateView1.snp.bottom).offset(14)
            $0.left.equalToSuperview().offset(32)
        }
    }
    
    func textName(text: String){
        labelName.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
