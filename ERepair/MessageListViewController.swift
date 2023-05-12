//
//  MessageListViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 24.04.23.
// 1 32

import UIKit
import FirebaseDatabase
import FirebaseDatabaseSwift

class MessageListViewController: UIViewController {
    
    private let backToHomeScreen = CustomButton(title: "Back to home", hasBackground: true, fontSize: .medium)
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        self.view.addSubview(self.backToHomeScreen)
        self.view.addSubview(self.myCollectionView)
        
        self.backToHomeScreen.translatesAutoresizingMaskIntoConstraints = false
        self.myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            <#T##UIView#>.topAnchor.constraint(equalTo: self.view.topAnchor),
            <#T##UIView#>.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            <#T##UIView#>.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            <#T##UIView#>.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            <#T##UIView#>.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            <#T##UIView#>.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            <#T##UIView#>.widthAnchor.constraint(equalToConstant: <#Double#>),
            <#T##UIView#>.heightAnchor.constraint(equalToConstant: <#Double#>),
//            self.myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            self.myCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.myCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
