//
//  AlertViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 02.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    let alertView = AlertView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.55)
        view.addSubview(alertView)
        configView()
    }
    
    func configView(){
        alertView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(190)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-250)
        }
        
        alertView.okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
    }
    
    func errorView(errorType: String, image: UIImage){
        alertView.errorTypeLabel.text = errorType
        alertView.imgView.image = image
    }
    
    @objc func okAction(){
    dismiss(animated: true, completion: nil)
    }
}
