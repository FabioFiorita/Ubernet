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
    @StateObject var vm = ProvidersViewModel()
    @State private var user = User(name: "", city: "", email: "", phone: "", state: "", installer: false)
    
    var body: some View {
        Group {
            if fbManager.signedIn {
                if user.installer {
                    InstallerTabBarView(vm: vm)
                } else {
                    UserTabBarView(vm: vm)
                }
            } else {
                VStack {
                    Spacer()
                    Text("Ubernet")
                        .font(.largeTitle)
                        .fontWeight(.light)
                    Text("Encontre provedores de Internet perto de você").fontWeight(.light)
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 320, height: 320)
                        .scaledToFit()
                    Spacer()
                    HStack {
                        Button {
                            showSignInModal = true
                        } label: {
                            Text("JÁ TENHO CONTA")
                        }
                        .buttonStyle(.bordered)
                        .frame(width: 140)
                        Button {
                            showSignUpModal = true
                        } label: {
                            Text("ABRIR MINHA CONTA")
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(width: 140)
                    }
                    
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
            user = fbManager.user ?? User(name: "", city: "", email: "", phone: "", state: "", installer: false)
            fbManager.signedIn = fbManager.isSignedIn
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
