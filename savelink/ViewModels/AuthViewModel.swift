//
//  AuthViewModel.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import Foundation
import LocalAuthentication

final class AuthViewModel: ObservableObject {
    
    private let authRepository: AuthRepository
    
    @Published var username: User?
    @Published var errorString: String?
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.username = authRepository.getCurrentUser()
    }
    
    func login(txtUser: String, txtPass: String) {
        
        authRepository.login(user: txtUser, pass: txtPass) { [weak self] results in
            
            switch results {
            case .success(let user):
                self?.username = user
            case .failure(let error):
                self?.errorString = error.localizedDescription
            }
        }
    }
    
    func loginWithFacebook() {
        
        authRepository.loginWithFacebook() { [weak self] results in
            
            switch results {
            case .success(let user):
                self?.username = user
            case .failure(let error):
                self?.errorString = error.localizedDescription
            }
        }
    }
    
    func logout() {
        do {
            try authRepository.logout()
            self.username = nil
            
        } catch  {
            print("Error al logout: \(error.localizedDescription)")
        }
    }
    
    func register(txtUser: String, txtPass: String) {
        
        authRepository.registerUser(user: txtUser, pass: txtPass) { [weak self] results in
            
            switch results {
            case .success(let user):
                self?.username = user
            case .failure(let error):
                self?.errorString = error.localizedDescription
            }
        }
    }
    
    func faceIDLogin() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Login con FaceID") { success, error in
                
                if success {
                    self.username = User(email: "FaceID")
                    
                } else {
                    self.username = nil
                    print("Fallo en FaceID")
                }
                
            }
            
        }
    }
    
}

