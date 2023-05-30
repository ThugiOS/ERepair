//
//  HomeViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//393x852 

import UIKit
import CoreImage

class UserViewController: UIViewController {
    
    //MARK: - UI Components
    private let logOutButton = CustomButton(title: "Выход", hasBackground: false, fontSize: .medium)
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Hello "
        label.numberOfLines = 3
        return label
    }()
    private let sendMessageButton = CustomButton(title: "Написать мастеру", hasBackground: true, fontSize: .medium)
    private let allContactsButton = CustomButton(title: "Контакты", hasBackground: true, fontSize: .medium)
    private let qrCodeImageView = UIImageView(frame: .zero)
    
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
                    self.label.text = "Привет, \(user.username)!\nДля получения скидки\nпокажи QR-код мастеру."
                    generateQRCode(text: "\(user.userUID)", imageView: qrCodeImageView)
                }
            }
        }

    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(logOutButton)
        self.view.addSubview(label)
        self.view.addSubview(qrCodeImageView)
        self.view.addSubview(sendMessageButton)
        self.view.addSubview(allContactsButton)
        
        self.logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        self.allContactsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logOutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Double(self.view.bounds.height * 0.1)),
            self.logOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            
            self.label.topAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: Double(self.view.bounds.height * 0.08)),
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.qrCodeImageView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 10.0),
            self.qrCodeImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.qrCodeImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.50),
            self.qrCodeImageView.heightAnchor.constraint(equalTo: self.qrCodeImageView.widthAnchor),
            
            self.sendMessageButton.topAnchor.constraint(equalTo: self.qrCodeImageView.bottomAnchor, constant: Double(self.view.bounds.height * 0.08)),
            self.sendMessageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sendMessageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            self.sendMessageButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.allContactsButton.topAnchor.constraint(equalTo: self.sendMessageButton.bottomAnchor, constant: 10),
            self.allContactsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.allContactsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            self.allContactsButton.heightAnchor.constraint(equalToConstant: 55.0),
        ])
    }
    
    // MARK: - Private Methods
    private func generateQRCode(text: String, imageView: UIImageView) {
        let data = text.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10) // Масштабирование QR-кода
            if let output = filter.outputImage?.transformed(by: transform) {
                let qrCodeImage = UIImage(ciImage: output)
                imageView.image = qrCodeImage
            }
        }
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
