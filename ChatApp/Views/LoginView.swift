//
//  LoginView.swift
//  ChatApp
//
//  Created by Rahul on 02/06/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private func login() async {
        do {
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            //go to main screen
            
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
            SecureField("Password", text: $password)
                .textContentType(.password)
            
            HStack {
                Spacer()
                
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .disabled(!isFormValid)
                
                Button("Register") {
                    
                }
            }
            
            Text(errorMessage)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
