//
//  ContentView.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var authvm: AuthViewModel
    
    @State private var txtUser = ""
    @State private var txtPassword = ""
    @State private var onFullCover = false
    @State private var isOnLoading = false
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                Image(systemName: "lock")
                    .foregroundStyle(.blue)
                    .font(.system(size: 50, weight: .medium))
                    .padding()
            }
            .frame(width: 85, height: 85)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.white)
            }
            .padding(20)
            
            VStack(spacing: 5) {
                Text("Welcome to ")
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundStyle(.black)
                +
                Text("JeanPps")
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundStyle(.bluemain)
                
                Text("Progresando y desarrollando")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12, weight: .bold))
            }
            .padding(30)
            
            VStack(spacing: 15) {
                HStack {
                    Text("Reference user")
                        .foregroundStyle(.gray)
                        .frame(width: 95, alignment: .leading)
                        .fontWeight(.light)
                    
                    TextField("Jeanpier123", text: $txtUser)
                        .foregroundStyle(.black)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .frame(width: 350, height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                }
                
                HStack {
                    Text("Passwor key")
                        .foregroundStyle(.gray)
                        .frame(width: 95, alignment: .leading)
                        .fontWeight(.light)
                    
                    SecureField("", text: $txtPassword)
                        .keyboardType(.emailAddress)
                        .foregroundStyle(.black)
                    
                }
                .padding()
                .frame(width: 350, height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                }
            }
            .font(.system(size: 13))
            .padding(.vertical, 20)
            
            VStack(spacing: 15) {
                
                if let error = authvm.errorString {
                    Text("Error de registro: \(error)")
                        .frame(width: 350, height: 40)
                        .lineLimit(3)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                Button {
                    withAnimation {
                        isOnLoading = true
                        authvm.login(txtUser: txtUser, txtPass: txtPassword)
                        isOnLoading = false
                    }
                    
                } label: {
                    HStack {
                        if isOnLoading {
                            ProgressView()
                            
                        }else {
                            Text("Sign in")
                                .bold()
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.black)
                    }
                }
                
                Button {
                    withAnimation {
                        isOnLoading = true
                        authvm.loginWithFacebook()
                        isOnLoading = false
                    }
                    
                } label: {
                    HStack {
                        if isOnLoading {
                            ProgressView()
                            
                        }else {
                            Text("Access with Facebook")
                                .bold()
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.blue)
                    }
                }
                
                
                
                Button {
                    //FACE ID
                    authvm.faceIDLogin()
                } label: {
                    HStack {
                        Image(systemName: "faceid")
                            .font(.system(size: 22))
                            .bold()
                        Text("Face ID")
                            .bold()
                    }
                    .foregroundStyle(.black)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                            .foregroundStyle(.clear)
                    }
                }
                
            }
            .padding(.vertical, 20)
            .padding(.bottom)
            
            
            Spacer()
            
            
            Button("Crear cuenta") {
                onFullCover.toggle()
                authvm.errorString = nil
            }
            
            Text("By Jeanpiere Laura - Lima for my all my apps Sign In, made 23 december 2024 in mac mini M1")
                .frame(maxWidth: 320, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .background(.mainview)
        .fullScreenCover(isPresented: $onFullCover) {
            RegisterView(authvm: authvm)
        }
    }
}

#Preview {
    LoginView(authvm: AuthViewModel())
}
