//
//  ContactListViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 29.05.23.
//

import UIKit

class ContactListViewController: UIViewController {
    
    // MARK: - UI Components
    private let handleView = UIView(frame: .zero)
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "log")
        return iv
    }()
    private let phoneButton = CustomButton(title: "Позвонить", hasBackground: true, fontSize: .medium)
    private let emailButton = CustomButton(title: "Написать email", hasBackground: true, fontSize: .medium)
    private let telegramButton = CustomButton(title: "Telegram", hasBackground: true, fontSize: .medium)
    private let viberButton = CustomButton(title: "Viber", hasBackground: true, fontSize: .medium)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.phoneButton.addTarget(self, action: #selector(self.didTapPhoneNumberButton), for: .touchUpInside)
        self.emailButton.addTarget(self, action: #selector(self.didTapEmailButton), for: .touchUpInside)
        self.telegramButton.addTarget(self, action: #selector(didTapTelegramButton), for: .touchUpInside)
        self.viberButton.addTarget(self, action: #selector(didTapViberButton), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(handleView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(phoneButton)
        self.view.addSubview(emailButton)
        self.view.addSubview(telegramButton)
        self.view.addSubview(viberButton)
        
        self.handleView.backgroundColor = UIColor.lightGray
        self.handleView.layer.cornerRadius = 3
        
        self.handleView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.phoneButton.translatesAutoresizingMaskIntoConstraints = false
        self.emailButton.translatesAutoresizingMaskIntoConstraints = false
        self.telegramButton.translatesAutoresizingMaskIntoConstraints = false
        self.viberButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.handleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15.0),
            self.handleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.handleView.widthAnchor.constraint(equalToConstant: 55.0),
            self.handleView.heightAnchor.constraint(equalToConstant: 5.0),
            
            self.logoImageView.topAnchor.constraint(equalTo: self.handleView.bottomAnchor, constant: 120.0),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 120),
            self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor),
            
            self.phoneButton.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 20.0),
            self.phoneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.phoneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            self.phoneButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.emailButton.topAnchor.constraint(equalTo: self.phoneButton.bottomAnchor, constant: 10.0),
            self.emailButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            self.emailButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.telegramButton.topAnchor.constraint(equalTo: self.emailButton.bottomAnchor, constant: 10.0),
            self.telegramButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.telegramButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            self.telegramButton.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.viberButton.topAnchor.constraint(equalTo: self.telegramButton.bottomAnchor, constant: 10.0),
            self.viberButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.viberButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            self.viberButton.heightAnchor.constraint(equalToConstant: 55.0),
            
        ])
    }
    
    // MARK: - Selectors
    @objc
    private func didTapPhoneNumberButton() {
        UIApplication.shared.open(URL(string: "tel:+375447370766")!)
    }
    
    @objc
    private func didTapEmailButton() {
        UIApplication.shared.open(URL(string: "mailto:master@test.com")!)
    }
    
    @objc
    private func didTapTelegramButton() {
        UIApplication.shared.open(URL(string: "telegram://catthug")!)
    }
    
    @objc
    private func didTapViberButton() {
        UIApplication.shared.open(URL(string: "viber://contact?number=+375447370766")!)
    }
}

