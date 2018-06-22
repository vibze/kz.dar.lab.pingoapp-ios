//
//  SettingHeaderView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SettingHeaderView: UIView {
    
    var topLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myYellow
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-arrow"),for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(topLabel)
        self.addSubview(backButton)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        topLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(84)
            $0.right.equalToSuperview().offset(-84)
            $0.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(28)
            $0.height.equalTo(24)
        }
     }
    
    func titleName(title: String){
        topLabel.text = title
    }
    
}

