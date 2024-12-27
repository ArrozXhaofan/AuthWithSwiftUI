//
//  FacebookAuthDataSource.swift
//  savelink
//
//  Created by Jeanpiere Laura on 27/12/24.
//

import Foundation
import FacebookLogin

final class FacebookAuthDataSource {
    
    let manager = LoginManager()
    
    func loginWithFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        
        manager.logIn(permissions: ["email"], from: nil) { LoginManagerLoginResult , error in
            
            if let realError = error {
                print("Error: \(realError.localizedDescription)")
                completionBlock(.failure(realError))
                return
            }
            
            let token = LoginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "token empty"))
        }
    }
    
}
