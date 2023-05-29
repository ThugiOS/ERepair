//
//  NewMessageViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 13.05.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

class NewMessageViewController: UIViewController {
    
    // MARK: - UI Components
    private let handleView = UIView(frame: .zero)
    private let emailField = CustomTextField(fieldType: .email)
    private let textView = UITextView(frame: .zero)
    private let sendButton = CustomButton(title: "Send", hasBackground: true, fontSize: .medium)
    
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
        
        view.backgroundColor = .systemBackground
        
        view.frame.origin.y = UIScreen.main.bounds.height - modalHeight
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        textView.backgroundColor = .systemGray5
        handleView.backgroundColor = UIColor.lightGray
        handleView.layer.cornerRadius = 3
        
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
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.textView.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 10.0),
            self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textView.heightAnchor.constraint(equalToConstant: 150.0),
            
            self.sendButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 10.0),
            self.sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sendButton.heightAnchor.constraint(equalToConstant: 55.0),
            self.sendButton.widthAnchor.constraint(equalToConstant: 200.0),
        ])
    }
    
    // MARK: - Selectors
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
               let keyboardHeight = keyboardFrame.height
               let yOffset = modalHeight - keyboardHeight
               UIView.animate(withDuration: 0.3) {
                   self.view.frame.origin.y = yOffset
               }
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           UIView.animate(withDuration: 0.3) {
               self.view.frame.origin.y = UIScreen.main.bounds.height - self.modalHeight
           }
       }

    @objc func sendButtonTapped() {
        let newMessageId = UUID()
        
        let receipientEmail = emailField.text
        
        let dbRef = Database.database().reference()
        let userRef = dbRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: receipientEmail)
        userRef.getData { error, snapshot in
            guard error == nil,
                  let snapshot else {
                print(error ?? "error send data")
                return
            }
            
            guard let users = try? snapshot.data(as: [String: UserContent].self),
                  let userId = users.first?.value.id else {
                print("wrong data")
                return
            }
            
            let messageRef = dbRef.child("messages").child(userId).child(newMessageId.uuidString)
            
            let message = UserMessage(id: newMessageId,
                                      from: Auth.auth().currentUser!.email ?? "unknown sender",
                                      to: receipientEmail ?? "unknown receiver",
                                      content: self.textView.text,
                                      date: Date()
            )
            
           try? messageRef.setValue(from: message) { error in
               if error != nil {
                    print("error set value")
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

