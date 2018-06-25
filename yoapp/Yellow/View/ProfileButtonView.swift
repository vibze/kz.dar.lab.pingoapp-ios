//
//  ProfileButtonView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ProfileButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: "FEC95F")
        self.clipsToBounds = false
        self.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.titleLabel?.font = UIFont(name: "ProximaNovaSoft-Bold", size: 18)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonTitle(title:String){
        self.setTitle(title, for: .normal)
    }
    
    
}
