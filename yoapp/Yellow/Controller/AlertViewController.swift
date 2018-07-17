//
//  AlertViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 02.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
    func closeView(popupVC: AlertViewController)
}

class AlertViewController: UIViewController {
    
    let alertView = AlertView()
    let sendMessageAlert = SendAlerView()
    var delegate: AlertViewDelegate?
    
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
        
    }
    
    func configView(isError: Bool){
        if isError{
        view.addSubview(alertView)
        alertView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            if screenHeight == 568{
                $0.height.equalTo(195)
            }else{
                $0.height.equalTo(225)
            }
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
        }
            alertView.okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
            
        }else{
            view.addSubview(sendMessageAlert)
            sendMessageAlert.snp.makeConstraints{
                $0.centerY.equalToSuperview()
                if screenHeight == 568{
                    $0.height.equalTo(195)
                }else{
                    $0.height.equalTo(225)
                }
                $0.left.equalToSuperview().offset(24)
                $0.right.equalToSuperview().offset(-24)
                
            }
            sendMessageAlert.submitButton.addTarget(self, action: #selector(sendMessageOK), for: .touchUpInside)
        }
    }
    
    func errorView(errorType: String, image: UIImage){
        alertView.errorTypeLabel.text = errorType
        alertView.imgView.image = image
    }
    
    @objc func okAction(){
        dismiss(animated: false, completion: nil)
    }
    
    @objc func sendMessageOK(){
        delegate?.closeView(popupVC: self)
    }
}
