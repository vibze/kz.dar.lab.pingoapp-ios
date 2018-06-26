////
////  ContactsViewController.swift
////  yoapp
////
////  Created by Kurnmanbay Ayan on 6/17/18.
////  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
////

import UIKit
import SnapKit

private struct Constants {
    static let contactsCell = "contactsCell"
    static let sectionHeader = "sectionHeader"
}

class ContactsViewController: UIViewController {

    var collectionView: UICollectionView!

    let sectionLabels = ["Недавние", "Все, кто в теме"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let bundleID = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: bundleID)
//        }
        
        view.backgroundColor = UIColor(hexString: "6BBE90")
        collectionViewSetup()
        textFieldSetup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let searchTextField = SearchTextField()
    
    func textFieldSetup() {
        self.view.addSubview(searchTextField)
        searchTextField.delegate = self
        searchTextField.snp.makeConstraints { (constraint) in
            constraint.top.left.equalTo(20)
            constraint.height.equalTo(48)
            constraint.width.equalTo(self.view.frame.width - 2 * 20)
        }
    }
    
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 21, bottom: 12, right: 21)
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
            constraint.left.right.bottom.equalToSuperview()
            constraint.top.equalToSuperview().offset(87)
        }
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionLabels.count
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
        vc.contact = "Hello"
        self.present(vc, animated: true, completion: nil)
    }
}

extension ContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.never
        textField.leftViewMode = .never
        self.hideKeyboard()
        textField.placeholder = ""
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 0 {
                textField.leftViewMode = UITextFieldViewMode.always
                textField.leftViewMode = .always
                let attributes = [
                    NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                ]
                textField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
            }
        }
    }
}




