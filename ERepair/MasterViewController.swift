//
//  MasterViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 31.03.23.
//

import UIKit

class MasterViewController: UIViewController {
    //MARK: - UI Components

    private let logOut = CustomButton(title: " Log Out ", hasBackground: true, fontSize: .small)
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
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
                self.label.text = "\(user.username)\n\(user.email)\n\(user.userUID)"
            }
        }

        
        self.logOut.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(label)
        self.view.addSubview(logOut)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        logOut.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            logOut.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            logOut.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

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
}

