//
//  LoginView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var fbManager: FirebaseManager
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureField("Senha", text: $password)
                    .textContentType(.password)
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    fbManager.signIn(email: email, password: password)
                } label: {
                    Text("Entrar")
                }
            }
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
