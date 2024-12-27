//
//  FirebaseAuthDataSource.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class FirebaseAuthDataSource {
    
    private let facebookAuth = FacebookAuthDataSource()
    
    //UPDATE USER STATE
    func getCurrenUser() -> User? {
        
        guard let username = Auth.auth().currentUser?.email else {
            return nil
        }
        return User(email: username)
    }
    
    //LOGIN WITH EMAIL
    func login(email: String, pass: String, completion: @escaping( Result<User,Error> ) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: pass) { AuthDataResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            let userEmail = AuthDataResult?.user.email ?? "Name User"
            completion(.success(User(email: userEmail)))
            print("User creaded: \(userEmail)")
        }
    }
    
    //ACCESS WITH FACEBOOK
    func loginWithFacebook(completion: @escaping( Result<User,Error> ) -> Void) {
        facebookAuth.loginWithFacebook { results in
            
            switch results {
                
            case .success(let token):
                
                let tokenUser = FacebookAuthProvider.credential(withAccessToken: token)
                
                Auth.auth().signIn(with: tokenUser) { AuthDataResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(error))
                        return
                    }
                    let userEmail = AuthDataResult?.user.email ?? "Name User"
                    completion(.success(User(email: userEmail)))
                }
                
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //LOGOUT USER
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    
    //REGISTER NEW USER
    func registerNewUser(email: String, pass: String, completion: @escaping( Result<User,Error> ) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: pass) { AuthDataResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            let userEmail = AuthDataResult?.user.email ?? "Name User"
            completion(.success(User(email: userEmail)))
            print("User creaded: \(userEmail)")
        }
    }
    
}
