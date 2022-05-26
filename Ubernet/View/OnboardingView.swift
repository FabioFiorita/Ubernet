//
//  LoginView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var fbManager: FirebaseManager
    @State private var showSignUpModal = false
    @State private var showSignInModal = false
    var body: some View {
        Group {
            if fbManager.signedIn {
                TabBarView()
            } else {
                VStack {
                    Text("Ubernet")
                        .font(.largeTitle)
                    Text("Encontre provedores de Internet perto de você").fontWeight(.light)
                    Image("logo")
                        .resizable()
                        .frame(width: 350, height: 350)
                        .scaledToFit()
                    Spacer()
                    Button {
                        showSignUpModal = true
                    } label: {
                        Text("ABRIR MINHA CONTA")
                    }
                    .buttonStyle(.borderedProminent)
                    Button {
                        showSignInModal = true
                    } label: {
                        Text("JÁ TENHO CONTA")
                    }
                    .buttonStyle(.bordered)
                }
                .sheet(isPresented: $showSignUpModal) {
                    RegisterView()
                }
                .sheet(isPresented: $showSignInModal) {
                    LoginView()
                }
            }
        }
        
        .onAppear {
            fbManager.signedIn = fbManager.isSignedIn
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
