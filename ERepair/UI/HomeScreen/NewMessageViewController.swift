//
//  NewMessageViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 13.05.23.
//

import UIKit

class NewMessageViewController: UIViewController {
    
    // MARK: - UI Components
    private let handleView: UIView = {
        let handleView = UIView()
        handleView.backgroundColor = UIColor.lightGray
        handleView.layer.cornerRadius = 3
        return handleView
    }()
    private let emailField = CustomTextField(fieldType: .email)
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 10
        textView.text = " Здравствуйте, "
        textView.font = .systemFont(ofSize: 16.0)
        return textView
    }()
    private let sendButton = CustomButton(title: "Отправить", hasBackground: true, fontSize: .medium)
    
    // MARK: - Variables
    private let modalHeight: CGFloat = UIScreen.main.bounds.height / 2
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupUI()
        
        hideKeyboardWhenTappedAround()

        self.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.view.frame.origin.y = UIScreen.main.bounds.height - modalHeight
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.emailField.text = "master@test.com"
        
        self.view.addSubview(handleView)
        self.view.addSubview(emailField)
        self.view.addSubview(textView)
        self.view.addSubview(sendButton)

        self.handleView.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.handleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15.0),
            self.handleView.widthAnchor.constraint(equalToConstant: 55.0),
            self.handleView.heightAnchor.constraint(equalToConstant: 5.0),
            self.handleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.emailField.topAnchor.constraint(equalTo: self.handleView.bottomAnchor, constant: 15.0),
            self.emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            self.emailField.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.textView.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 5.0),
            self.textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            self.textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.18),
            
            self.sendButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 15.0),
            self.sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sendButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.07),
            self.sendButton.widthAnchor.constraint(equalToConstant: 200.0),
        ])
    }
    
    // MARK: - Selectors
    @objc
    func keyboardWillShow(notification: NSNotification) {
           if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
               let keyboardHeight = keyboardFrame.height
               let yOffset = modalHeight - keyboardHeight
               UIView.animate(withDuration: 0.3) {
                   self.view.frame.origin.y = yOffset
               }
           }
       }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = UIScreen.main.bounds.height - self.modalHeight
        }
    }

    @objc
    func sendButtonTapped() {
        DispatchQueue.main.async {
            let receipientEmail = self.emailField.text
            let textMessage = self.textView.text
            
            MessageManager.shared.sendMassage(emailField: receipientEmail, textView: textMessage)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

