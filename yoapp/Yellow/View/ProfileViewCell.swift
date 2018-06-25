//
//  ProfileViewCell.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit


class ProfileViewCell: UITableViewCell {

    var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEC95F")
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    var settingLabel: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "ProximaNovaSoft-Bold", size: 18)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        setUpView()
    }
    
    func setUpView(){
        self.addSubview(hiddenView)
        hiddenView.addSubview(backView)
        backView.addSubview(settingLabel)
        
        hiddenView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(70)
            $0.bottom.equalToSuperview().offset(0)
        }
        
        backView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
            $0.height.equalTo(50)
        }
        
        settingLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
