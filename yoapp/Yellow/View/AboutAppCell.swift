//
//  AboutAppCell.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AboutAppCell: UITableViewCell {
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .myPurple
        label.text = "YoApp"
        return label
    }()
    
    var aboutBackgroundView = UIView()
    
    var aboutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myYellow
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.addSubview(appNameLabel)
        self.addSubview(aboutBackgroundView)
        aboutBackgroundView.backgroundColor = .myYellow
        aboutBackgroundView.addSubview(aboutLabel)
        setUpView()
    }
    
    func setUpView(){
        appNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
        }
        
        aboutBackgroundView.snp.makeConstraints{
            $0.top.equalTo(appNameLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(90)
        }
        
        aboutLabel.snp.makeConstraints{
            $0.top.equalTo(aboutBackgroundView.snp.top).offset(4)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
