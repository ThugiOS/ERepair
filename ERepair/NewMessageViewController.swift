//
//  NewMessageViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 13.05.23.
//

import UIKit
import FirebaseDatabase
import FirebaseDatabaseSwift


class NewMessageViewController: UIViewController {
    
    // MARK: - UI Components
    private let emailField = CustomTextField(fieldType: .username)
    private let textView = UITextView(frame: .zero)
    private let sendButton = CustomButton(title: "Send", hasBackground: false, fontSize: .medium)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(emailField)
        self.view.addSubview(textView)
        self.view.addSubview(sendButton)

        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false


        
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0),
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.textView.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 10.0),
            self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textView.heightAnchor.constraint(equalToConstant: 250.0),
            
            self.sendButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 10.0),
            self.sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sendButton.heightAnchor.constraint(equalToConstant: 55.0),
            self.sendButton.widthAnchor.constraint(equalToConstant: 200.0),
        ])
    }
    
    // MARK: - Selectors
}

extension NewMessageViewController: UITextViewDelegate {
    
}
