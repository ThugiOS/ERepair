//
//  AuthManager.swift
//  ERepair
//
//  Created by Никитин Артем on 19.04.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseDatabaseSwift

class AuthManager {
    
    public static let shared = AuthManager()
    
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
            // добавление пользователя в realtime database
            let dbRef = Database.database().reference()
            let userRef = dbRef.child("users").child(Auth.auth().currentUser!.uid)
            let newUser = UserContent(id: String(Auth.auth().currentUser!.uid), email: email)
            try? userRef.setValue(from: newUser) { error in
                if let error {
                    print(error)
                } else {
                    print("User add to realtime database")
                }
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
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?)->Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil) // If nil, then log in.
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgotPassword(with email: String, completion: @escaping (Error?)->Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData["username"] as? String,
                   let email = snapshotData["email"] as? String {
                    let user = User(username: username, email: email, userUID: userUID)
                    completion(user, nil)
                }
            }
    }
}
