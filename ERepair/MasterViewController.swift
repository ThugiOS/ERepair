//
//  MasterViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 31.03.23.
//

import UIKit

class MasterViewController: UIViewController {
    //MARK: - UI Components

    private let logOut = CustomButton(title: "Log Out", hasBackground: true, fontSize: .small)

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.logOut.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        
        self.view.addSubview(logOut)
        logOut.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logOut.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logOut.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
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

