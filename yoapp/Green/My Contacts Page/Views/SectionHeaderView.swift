//
//  SectionHeaderView.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/25/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class SectionHeaderView: UIView {
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(hexString: "81E2AA")
        return headerView
    }()
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.init(hexString: "308757")
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Все контакты"
        return headerLabel
    }()
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hexString: "6BBE90")
        setupViews()
    }
    
    func setupViews() {
        headerView.addSubview(headerLabel)
        addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.left.equalTo(self.snp.left).offset(0)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(25)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.left.equalTo(self.snp.left).offset(20)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(25)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
