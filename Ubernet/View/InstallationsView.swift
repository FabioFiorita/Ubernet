//
//  InstallationsView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct InstallationsView: View {
    @EnvironmentObject var fbManager: FirebaseManager
    @ObservedObject var vm: ProvidersViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(fbManager.bookings, id: \.self) { booking in
                    NavigationLink(destination: InstallationDetailView(booking: booking, vm: vm)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(booking.name)
                                .font(.title)
                            Text("Data: \(booking.date, formatter: dateFormatter)")
                                .fontWeight(.light)
                            Text("Telefone: \(booking.phone)")
                                .fontWeight(.light)
                        }
                    }
                }
            }
            .task {
                fbManager.fetchInstallations()
            }
            .navigationTitle("Agendamentos")
        }
    }
}

struct InstallationsView_Previews: PreviewProvider {
    static var previews: some View {
        InstallationsView(vm: ProvidersViewModel())
    }
}
