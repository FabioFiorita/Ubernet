//
//  TabBarView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct UserTabBarView: View {
    @ObservedObject var vm: ProvidersViewModel
    @EnvironmentObject var fbManager: FirebaseManager
    var body: some View {
        TabView {
            PlansView(vm: vm)
                .tabItem {
                    Label("Planos", systemImage: "doc.text.fill")
                }
            InstallersMapView(vm: vm)
                .tabItem {
                    Label("Instaladores", systemImage: "map.fill")
                }
            
        }
        .task {
            await fbManager.fetchCurrentUser()
        }
    }
}

struct UserTabBar_Previews: PreviewProvider {
    static var previews: some View {
        UserTabBarView(vm: ProvidersViewModel())
    }
}
