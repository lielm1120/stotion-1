//
//  DataBase.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import Foundation
import Firebase
import FirebaseFirestore

enum SignUpError: Error {
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case unknownError
    case noUserFound

}

class DataStructure{
    static var email: String = ""
    static var name: String = ""
    static var tasks: [Task] = []
    static var counetr = 0
}
func increaceCounter(){
    DataStructure.counetr += 1
}

class DataBase{
    let db = Firestore.firestore()
    func signUpUser(email: String, password: String, name: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                completion(.failure(SignUpError.noUserFound))
                return
            }
            self.db.collection("users").document(user.uid).setData([
                "name": name,
                "email": email
            ]) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(authResult!))
            }
        }
    }
    func retrieveUsername(withEmail email: String, completion: @escaping (_ username: String?) -> Void) {
        self.db.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
            } else {
                if let document = snapshot?.documents.first {
                    let username = document.data()["name"] as? String
                    completion(username)
                } else {
                    completion(nil)
                }
            }
        }
    }

}
