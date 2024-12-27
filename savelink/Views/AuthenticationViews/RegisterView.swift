//
//  RegisterView.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import SwiftUI

struct RegisterView: View {
        
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var authvm: AuthViewModel
    
    @State private var txtUser = ""
    @State private var txtPassword = ""
    
    @State private var isOnLoading = false
 
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Spacer()
                
                VStack {
                    Image(systemName: "lock.circle.dotted")
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
                    Text("Create a new ")
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundStyle(.black)
                    +
                    Text("Accout")
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
                            .font(.system(size: 15, weight: .light))
                            .frame(width: 110, alignment: .leading)
                        
                        TextField("Jeanpier123", text: $txtUser)
                            .foregroundStyle(.black)
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
                            .font(.system(size: 15, weight: .light))
                            .frame(width: 110, alignment: .leading)
                        
                        SecureField("", text: $txtPassword)
                            .foregroundStyle(.black)

                    }
                    .padding()
                    .frame(width: 350, height: 45)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.vertical, 20)
                
                VStack(spacing: 15) {
                    Button {
                        isOnLoading.toggle()
                        authvm.register(txtUser: txtUser, txtPass: txtPassword)
                        isOnLoading.toggle()

                    } label: {
                        HStack {
                            if isOnLoading {
                                ProgressView()
                            } else {
                                Text("Create account")
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
                    
                    if let error = authvm.errorString {
                        Text("Error de registro: \(error)")
                            .frame(width: 350, height: 40)
                            .lineLimit(3)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }
                .padding(.vertical, 20)
                .padding(.bottom, 150)
                
                
                Spacer()
                
                Text("By Jeanpiere Laura - Lima for my all my apps Sign In, made 23 december 2024 in mac mini M1")
                    .frame(maxWidth: 320, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .background(.mainview)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        authvm.errorString = nil
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView(authvm: AuthViewModel())
}
