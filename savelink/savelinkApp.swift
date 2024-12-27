//
//  savelinkApp.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import SwiftUI
import FirebaseCore
import FacebookLogin

@main
struct savelinkApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var auth: AuthViewModel = AuthViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            
            if let _ = auth.username {
                HomeView(authvm: auth)
                
            } else {
                LoginView(authvm: auth)
                
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        return true
        
    }
}
