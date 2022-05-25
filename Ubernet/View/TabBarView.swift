//
//  TabBarView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var vm = ProvidersViewModel()
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

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
