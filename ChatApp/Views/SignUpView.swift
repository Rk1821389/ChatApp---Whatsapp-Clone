//
//  SignUpView.swift
//  ChatApp
//
//  Created by Rahul on 01/06/23.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    
    @EnvironmentObject private var models: Models
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !displayName.isEmpty
    }
    

    
    private func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await models.updateDisplayName(for: result.user, displayName: displayName)
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
            SecureField("Password", text: $password)
                .textContentType(.password)
            TextField("Display Name", text: $displayName)
                .textContentType(.name)
            
            HStack {
                Spacer()
                
                Button("Sign Up") {
                    Task {
                        await signUp()
                    }
                }.disabled(!isFormValid)
                    .buttonStyle(.borderless)
                
                Button("Login") {
                    //Take the user to login screen
                }
                
                Spacer()
            }
            
            Text(errorMessage)
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Models())
    }
}
