//
//  InstallerTabBarView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 26/05/22.
//

import SwiftUI

struct InstallerTabBarView: View {
    @ObservedObject var vm: ProvidersViewModel
    @EnvironmentObject var fbManager: FirebaseManager
    var body: some View {
        TabView {
            InstallationsView(vm: vm)
                .tabItem {
                    Label("Agendamentos", systemImage: "calendar")
                }
            PlansView(vm: vm)
                .tabItem {
                    Label("Planos", systemImage: "doc.text.fill")
                }
        }
        .task {
            await fbManager.fetchCurrentUser()
        }
    }
}

struct InstallerTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        InstallerTabBarView(vm: ProvidersViewModel())
    }
}
