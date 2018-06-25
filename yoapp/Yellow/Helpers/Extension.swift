//
//  Extension.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension UITableViewController {
    
    @objc func bactToVC() {
//        self.navigationController?.popViewController(animated: true)
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func openViewController(viewController: UIViewController){
//        let vc = UINavigationController(rootViewController: viewController)
//        print(viewController)
//        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.popToViewController(vc, animated: true)
//        navigationController?.present(vc, animated: true, completion: nil)
//        navigationController?.show(vc, sender: nil)
        let vc = viewController
        self.present(vc, animated: true, completion: nil)
    }
}
