//
//  AuthRepository.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import Foundation

final class AuthRepository {
    
    private let firebaseDataSource: FirebaseAuthDataSource
    
    init(firebaseDataSource: FirebaseAuthDataSource = FirebaseAuthDataSource()) {
        self.firebaseDataSource = firebaseDataSource
    }
    
    func getCurrentUser() -> User? {
        firebaseDataSource.getCurrenUser()
    }
    
    func login(user: String, pass: String, completion: @escaping(Result<User, Error>) -> Void) {
        firebaseDataSource.login(email: user, pass: pass, completion: completion)
    }
    
    func loginWithFacebook(completion: @escaping(Result<User, Error>) -> Void) {
        firebaseDataSource.loginWithFacebook(completion: completion)
    }
    
    func logout() throws {
        try firebaseDataSource.logout()
    }
    
    func registerUser(user: String, pass: String, completion: @escaping(Result<User, Error>) -> Void) {
        
        firebaseDataSource.registerNewUser(email: user,
                                           pass: pass,
                                           completion: completion)
    }
}
