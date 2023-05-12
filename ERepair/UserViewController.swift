//
//  HomeViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//

import UIKit

class UserViewController: UIViewController {
    //MARK: - UI Components
    
    private let logOut = CustomButton(title: " Log Out ", hasBackground: true, fontSize: .small)
    private let sendMessage = CustomButton(title: "Send message", hasBackground: true, fontSize: .small)

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Hello "
        label.numberOfLines = 2
        return label
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
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
        
        self.logOut.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.sendMessage.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(label)
        self.view.addSubview(logOut)
        self.view.addSubview(sendMessage)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        logOut.translatesAutoresizingMaskIntoConstraints = false
        sendMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            logOut.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            logOut.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            sendMessage.topAnchor.constraint(equalTo: logOut.bottomAnchor, constant: 150),
            sendMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sendMessage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            sendMessage.heightAnchor.constraint(equalToConstant: 55.0),
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
    
    @objc func buttonPressed() {
        let modalVC = MessageListViewController()
        modalVC.modalPresentationStyle = .fullScreen // Устанавливаем стиль отображения модального окна
        modalVC.view.backgroundColor = .white // Устанавливаем цвет фона модального окна

        // Отображаем модальное окно
        self.present(modalVC, animated: true, completion: nil)
    }
    
}
