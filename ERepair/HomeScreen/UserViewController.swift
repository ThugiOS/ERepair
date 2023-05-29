//
//  HomeViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//

import UIKit

class UserViewController: UIViewController {
    
    //MARK: - UI Components
    private let logOutButton = CustomButton(title: " Log Out ", hasBackground: false, fontSize: .small)
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Hello "
        label.numberOfLines = 2
        return label
    }()
    private let sendMessageButton = CustomButton(title: "Send message", hasBackground: true, fontSize: .medium)
    private let allContactsButton = CustomButton(title: "Contacts", hasBackground: true, fontSize: .medium)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
                
        self.logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.sendMessageButton.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
        self.allContactsButton.addTarget(self, action: #selector(didTapContacts), for: .touchUpInside)
        
        DispatchQueue.main.async {
            AuthService.shared.fetchUser { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    AlertManager.showFetchingUserError(on: self, with: error)
                    return
                }
                
                if let user = user {
                    self.label.text = "Hello, \(user.username)!"
                }
            }
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(label)
        self.view.addSubview(logOutButton)
        self.view.addSubview(sendMessageButton)
        self.view.addSubview(allContactsButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        allContactsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            logOutButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            logOutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            sendMessageButton.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 150),
            sendMessageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sendMessageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            sendMessageButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            allContactsButton.topAnchor.constraint(equalTo: sendMessageButton.bottomAnchor, constant: 10),
            allContactsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            allContactsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            allContactsButton.heightAnchor.constraint(equalToConstant: 55.0),
        ])
    }
    
    //MARK: - Selectors
    @objc
    private func didTapLogOut() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as?
                SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    @objc
    func didTapSendMessage() {
        let modalVC = MessageListViewController()
        modalVC.modalPresentationStyle = .fullScreen
        self.present(modalVC, animated: true, completion: nil)
    }
    
    @objc
    func didTapContacts() {
        let modalVC = ContactListViewController()
        modalVC.modalPresentationStyle = .automatic
        self.present(modalVC, animated: true, completion: nil)
    }
}
