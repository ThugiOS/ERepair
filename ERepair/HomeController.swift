//
//  HomeController.swift
//  ERepair
//
//  Created by Никитин Артем on 24.03.23.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    
    //MARK: - Selectors
    @objc private func didTapLogout() {
 
    }
}
