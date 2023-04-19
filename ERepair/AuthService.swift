//
//  AuthService.swift
//  ERepair
//
//  Created by Никитин Артем on 19.04.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    /// A method to register the user
    /// - Parameters:
    ///   - registerUser: The user info (username, emai,l password)
    ///   - complection: A complection with two values...
    ///   - Bool: wasRegistered - Determines if the user was registered and saved in the database correctly
    ///   - Error?:  An optional error if firebase provides once
    public func registerUser(with registerUser: RegisterUserRequest,
                             complection: @escaping (Bool, Error?) -> Void) {
        let username = registerUser.username
        let email = registerUser.email
        let password  = registerUser.password

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            // пришла ошибка
            if let error {
                complection(false, error)
                return
            }
            // ошибки нет, но мы не получили пользователя
            guard let resultUser = result?.user else {
                complection(false, nil)
                return
            }
            // ошибок нет, пользователь есть
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                    
                ]) { error in
                    if let error {
                        complection(false, error)
                        return
                    }
                    complection(true, nil)
                }
             
        }
    }
}


