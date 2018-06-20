//
//  ContactsViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/17/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import SnapKit

private struct Constants {
    static let contactsCell = "contactsCell"
    static let sectionHeader = "sectionHeader"
}

class ContactsViewController: UIViewController {

    var collectionView: UICollectionView!

    let sectionLabels = ["Недавние"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.hideKeyboard()
        collectionViewSetup()
        backImageSet()
        textFieldSetup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont(name: "Avenir Next", size: 22)
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: " Поиск", attributes: attributes)
        
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.init(hexString: "9F4C76").cgColor
        textField.backgroundColor = UIColor.init(hexString: "58AD7E")
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        var image = UIImage(named: "search")
        imageView.image = image
        textField.leftView = imageView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    
    func textFieldSetup() {
        self.view.addSubview(searchTextField)
        searchTextField.delegate = self
        searchTextField.snp.makeConstraints { (constraint) in
            constraint.left.top.equalTo(20)
            constraint.height.equalTo(52)
            constraint.width.equalTo(self.view.frame.width - 40)
        }
    }
    
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 25, left: 21, bottom: 36, right: 21)
        layout.itemSize = CGSize(width: 68, height: 98)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ContactsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.contactsCell)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.sectionHeader)
        let flow = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSize(width: self.view.frame.width, height: 25)

        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (constraint) in
            constraint.left.right.bottom.equalTo(0)
            constraint.top.equalTo(87)
        }
    }
    
    func backImageSet() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "contactsBackground")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.sectionHeader, for: indexPath) as! SectionHeader
        sectionHeader.categoryTitleLabel.text = sectionLabels[indexPath.section]
        sectionHeader.backgroundColor = UIColor.init(hexString: "81E2AA")
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.contactsCell, for: indexPath) as! ContactsCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MessageViewController()
        vc.contact = "asdasdasd"
        self.present(vc, animated: true, completion: nil)
    }
}

extension ContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.never
        textField.leftViewMode = .never
        self.hideKeyboard()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 0 {
                textField.leftViewMode = UITextFieldViewMode.always
                textField.leftViewMode = .always
            }
        }
    }
}

extension UIViewController {
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        print(tap)
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.gestureRecognizers?.removeAll()
        view.endEditing(true)
    }
}




