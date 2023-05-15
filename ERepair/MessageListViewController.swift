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
    private let closeButton = CustomButton(title: "Close", hasBackground: false, fontSize: .medium)
    
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
        cell, indexPath, item in
        
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = item.content
        configuration.secondaryText = "From: \(item.from), \(item.date)"

        cell.contentConfiguration = configuration
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
        
        self.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
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
                print( "unknown")
                return
            }

            do {
                let messages = try snapshot.data(as: [UUID: UserMessage].self)

                let orderedIds = messages
                    .mapValues { $0.date }
                    .sorted(using: KeyPathComparator(\.value, order: .reverse))
                    .map(\.key)

                DispatchQueue.main.async {
                    self.messages = messages
                    self.orderedMessageIds = orderedIds
                    self.reloadCollectionViewData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func reloadCollectionViewData() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(self.orderedMessageIds, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.newMessage)
        
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.newMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50.0),
            self.closeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            
            self.collectionView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 10.0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75),
            
            self.newMessage.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10.0),
            self.newMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.newMessage.heightAnchor.constraint(equalToConstant: 55.0),
            self.newMessage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Selectors
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonNewMessagePressed() {
        let modalVC = NewMessageViewController()
        modalVC.modalPresentationStyle = .automatic
        modalVC.view.backgroundColor = .white
        self.present(modalVC, animated: true, completion: nil)
    }
}

// что-бы UUID поддерживался в качестве ключа словарей, которые приходят в codable
extension UUID: CodingKeyRepresentable {
    public init?<T>(codingKey: T) where T: CodingKey {
        self.init(uuidString: codingKey.stringValue)
    }

    public var codingKey: CodingKey { uuidString.codingKey }
}
