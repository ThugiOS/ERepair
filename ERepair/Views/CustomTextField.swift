//
//  CustomTextField.swift
//  ERepair
//
//  Created by Никитин Артем on 27.03.23.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
//        self.textAlignment =
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Email adress"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
