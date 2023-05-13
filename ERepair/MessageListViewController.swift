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
    
    // MARK: - UI Components
    private let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let newMessage = CustomButton(title: "New message", hasBackground: true, fontSize: .medium)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        setupUI()
        
        self.newMessage.addTarget(self, action: #selector(buttonNewMessagePressed), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {

        self.view.addSubview(self.myCollectionView)
        self.view.addSubview(self.newMessage)
        
        self.myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.newMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0),
            self.myCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.myCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.myCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            self.myCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.80),
            
            self.newMessage.topAnchor.constraint(equalTo: self.myCollectionView.bottomAnchor, constant: 10.0),
            self.newMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.newMessage.heightAnchor.constraint(equalToConstant: 55.0),
            self.newMessage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Selectors    
    @objc func buttonNewMessagePressed() {
        let modalVC = NewMessageViewController()
        modalVC.modalPresentationStyle = .automatic
        modalVC.view.backgroundColor = .white
        self.present(modalVC, animated: true, completion: nil)
    }
}
