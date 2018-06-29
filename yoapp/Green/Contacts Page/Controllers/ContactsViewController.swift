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
    
    var registeredContactsList: [[Contact]] = []
    
    let searchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effect.isHidden = true
        return effect
    }()
    
    func getRegisteredContacts() {
        ContactsService().getRegisteredContacts { (registeredContacts) in
            for contacts in registeredContacts {
                if let contacts = contacts {
                    self.registeredContactsList.append(contacts)
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let bundleID = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: bundleID)
//        }
        getRegisteredContacts()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        collectionViewSetup()
        textFieldSetup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let searchTextField = SearchTextField()
    
    func textFieldSetup() {
        self.view.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(blurEffectView)
        searchBackgroundView.addSubview(searchTextField)
    
        searchTextField.delegate = self
        searchBackgroundView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(80)
        }
        searchTextField.snp.makeConstraints {
            $0.top.left.equalTo(20)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().inset(20)
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
        collectionView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 60, right: 0)
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.alwaysBounceVertical = true
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.sectionHeader, for: indexPath) as! SectionHeader
        sectionHeader.categoryTitleLabel.text = sectionLabels[indexPath.section]
    
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return registeredContactsList[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.contactsCell, for: indexPath) as! ContactsCollectionViewCell
        
        cell.contact = registeredContactsList[indexPath.section][indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MessageViewController()
        vc.contact = "Arnold"
        openViewController(viewController: vc)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y > -80 ?
            setBlur(false, .clear, UIColor(hexString: "58AD7E", alpha: 0.2)) :
            setBlur(true, UIColor(hexString: "6BBE90"), UIColor(hexString: "58AD7E"))
    }
    
    func setBlur(_ isHidden: Bool, _ backColor: UIColor, _ textColor: UIColor) {
        blurEffectView.isHidden = isHidden
        searchBackgroundView.backgroundColor = backColor
        searchTextField.backgroundColor = textColor
    }
}

extension ContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.hideKeyboard()
    }
}




