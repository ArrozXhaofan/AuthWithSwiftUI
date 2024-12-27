//
//  HomeView.swift
//  savelink
//
//  Created by Jeanpiere Laura on 26/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authvm: AuthViewModel
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                HStack {
                    Text("Email")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text("\(authvm.username?.email ?? "No data")")
                }
                .fontDesign(.monospaced)
                .padding()
                
                Divider()
                
                Button {
                    
                    isLoading.toggle()
                    authvm.logout()
                    isLoading.toggle()
                    
                } label: {
                    HStack {
                        Text("Cerrar sesion")
                        
                        Spacer()
                        
                        if isLoading {
                            ProgressView()
                            
                        } else {
                            Image(systemName: "power")
                        }
                    }
                }
                .foregroundStyle(.red)
                .padding()
                

                
                Spacer()
                
            }
            .navigationTitle("Settings")
            .padding(.vertical)
            .toolbar {
                
            }
        }
        
    }
}

#Preview {
    HomeView(authvm: AuthViewModel())
}
