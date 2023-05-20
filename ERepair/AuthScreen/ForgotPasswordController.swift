//
//  ForgotPasswordController.swift
//  ERepair
//
//  Created by Никитин Артем on 24.03.23.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    //MARK: UI-Components
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailField = CustomTextField(fieldType: .email)
    private let resetButton = CustomButton(title: "Sign UP", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .medium)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.resetButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetButton)
        self.view.addSubview(signInButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150.0),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 230.0),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.resetButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.resetButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 12),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    //MARK: - Selectors
    @objc
    private func didTapForgotPassword() {
        let email = self.emailField.text ?? ""

        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }

            AlertManager.showPasswordResetSent(on: self)
        }
    }
    
    @objc
    private func didTapSignIn() {
        let vc = LoginController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
