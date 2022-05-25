//
//  BookingInstallationView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct BookingInstallationView: View {
    @State private var date = Date()
    @EnvironmentObject var fbManager: FirebaseManager
    @Binding var showBookingInstallation: Bool
    @State var plan: Plan
    var body: some View {
        NavigationView {
            Form {
                Text("Selecione a data e horário para a instalação")
                    .fontWeight(.light)
                DatePicker("Agendamento", selection: $date, in: Date()...)
                    .datePickerStyle(.graphical)
            }
            .navigationTitle("Agendamento")
            .toolbar {
                ToolbarItem {
                    Button {
                        fbManager.bookNewInstallation(name: fbManager.user?.name ?? "", email: fbManager.user?.email ?? "", city: fbManager.user?.city ?? "", state: fbManager.user?.state ?? "", phone: fbManager.user?.phone ?? "", date: date, planID: plan.id)
                        showBookingInstallation = false
                    } label: {
                        Text("Agendar")
                    }

                }
        }
        }
    }
}

struct BookingInstallationView_Previews: PreviewProvider {
    static var previews: some View {
        BookingInstallationView(showBookingInstallation: .constant(true), plan: Plan(id: 1, isp: "", downloadSpeed: 0, uploadSpeed: 0, description: "", pricePerMonth: 0, typeOfInternet: ""))
    }
}
