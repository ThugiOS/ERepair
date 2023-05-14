//
//  MessageListViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 24.04.23.
// 1 32

import UIKit
import FirebaseDatabase
import FirebaseDatabaseSwift

struct UserMessage: Codable, Identifiable {
    var id: UUID
    var from: String
    var to: String
    var content: String
    var date: Date
}

struct UserContent: Codable, Identifiable {
    var id: String
    var name: String
    var email: String?
    var phoneNumber: String?
    var avatar: String?
}

class MessageListViewController: UIViewController {
    
    typealias MessageId = UUID
    typealias Message = UserMessage
    typealias DataSource = UICollectionViewDiffableDataSource<Int, MessageId>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MessageId>
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    private let newMessage = CustomButton(title: "New message", hasBackground: true, fontSize: .medium)
    
    
    
    lazy var messageCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Message> {
        cell, indexPath, itemIdentifier in
        
    }
    
    lazy var dataSource = DataSource(collectionView: collectionView) {
        [messageCellRegistration, weak self]
        collectionView, indexPath, itemIdentifier in
        guard let self,
              let message = self.messages[itemIdentifier] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueConfiguredReusableCell(using: messageCellRegistration,
                                                                for: indexPath,
                                                                item: message
        )
        return cell
    }
    
    var messages: [UUID: Message] = [:]
    var orderedMessageIds: [UUID] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.newMessage.addTarget(self, action: #selector(buttonNewMessagePressed), for: .touchUpInside)
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView.collectionViewLayout = layout
        
        _ = messageCellRegistration
        _ = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    // MARK: - Private Methods
    private func updateData() {
        let dbRer = Database.database().reference()
        let messagesRef = dbRer.child("messages")
        messagesRef.getData { error, snapshot in
            guard error == nil,
                  let snapshot else {
                print(error ?? "unknown")
                return
            }
            
            guard let messages = try? snapshot.data(as: [UUID: UserMessage].self) else {
                print("Can not decode")
                return
            }
            
            DispatchQueue.main.async {
                self.messages = messages
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {

        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.newMessage)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.newMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.80),
            
            self.newMessage.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10.0),
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

