//
//  AboutAppViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AboutAppViewController: UITableViewController {
 
    let headerView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .myPurple
        label.text = "YoApp"
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .myYellow
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        configTableView()
        setUpViews()
    }
    
 func configTableView(){
        tableView.backgroundColor = UIColor(hexString: "FEC95F")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 50
 
        headerView.titleName(title: "О приложении")

         headerView.titleName(title: "О приложении")
        tableView.tableHeaderView = headerView
        headerView.backButton.addTarget(self, action: #selector(bactToVC), for: .touchUpInside)
    }
    
 
    func setUpViews(){
        tableView.addSubview(appNameLabel)
        tableView.addSubview(textLabel)
        
        appNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(90)
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints{
            $0.top.equalTo(appNameLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(150)
        }
        
        textLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been."
    }
    
}
