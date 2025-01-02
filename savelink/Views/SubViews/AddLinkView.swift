//
//  AddLinkView.swift
//  savelink
//
//  Created by Jeanpiere Laura on 29/12/24.
//

import SwiftUI

struct AddLinkView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: HomeViewModel
    @State var txtUrl = ""
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                Section {
                    TextField("url", text: $txtUrl)
                        .autocapitalization(.none)
                } header: {
                    Text("Add link")
                } footer: {
                    if let msj = vm.messageString {
                        Text(msj)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
            }
            .scrollDisabled(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    Text("New link")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        withAnimation {
                            vm.createNewLink(fromUrl: txtUrl)
                        }
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    AddLinkView(vm: HomeViewModel())
}
