//
//  MessageManager.swift
//  ERepair
//
//  Created by Никитин Артем on 4.06.23.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

class MessageManager {
    public static let shared = MessageManager()
    
    private init() {}
    
    public var messages: [UUID: UserMessage] = [:]
    public var orderedMessageIds: [UUID] = []
    
    public func sendMassage(emailField: String?, textView: String? ) {
        let newMessageId = UUID()
        
        let receipientEmail = emailField
        
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
                                      content: textView ?? "",
                                      date: Date()
            )
            
           try? messageRef.setValue(from: message) { error in
               if error != nil {
                    print("error set value")
                } else {
                    return
                }
            }
        }
    }
    
    public func getAllMessage() {
        let dbRer = Database.database().reference()
        let messagesRef = dbRer.child("messages").child(Auth.auth().currentUser!.uid)
        messagesRef.getData { error, snapshot in
            guard error == nil,
                  let snapshot else {
                print(error ?? "error update data")
                return
            }

            do {
                let messages = try snapshot.data(as: [UUID: UserMessage].self)

                let orderedIds = messages
                    .mapValues { $0.date }
                    .sorted(using: KeyPathComparator(\.value, order: .reverse))
                    .map(\.key)

                DispatchQueue.main.async {
                    self.messages = messages
                    self.orderedMessageIds = orderedIds
                }
            } catch {
                print(error)
            }
        }
    }
}
