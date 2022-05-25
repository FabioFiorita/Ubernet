//
//  RegisterView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var city = ""
    @State private var state = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var installer = false
    
    @EnvironmentObject var fbManager: FirebaseManager
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $name)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                TextField("Cidade", text: $city)
                    .textContentType(.addressCity)
                Picker("Selecione o Estado", selection: $state) {
                    ForEach(states, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Telefone", text: $phone)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                SecureField("Senha", text: $password)
                    .textContentType(.password)
                Toggle(isOn: $installer) {
                    Text("Instalador")
                }
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    fbManager.SignUp(name: name, email: email, city: city, state: state, phone: phone, installer: installer, password: password)
                } label: {
                    Text("Registrar")
                }
            }
            .navigationTitle("Cadastro")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
