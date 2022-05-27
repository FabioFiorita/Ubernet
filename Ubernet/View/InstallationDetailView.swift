//
//  InstallationDeatilView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct InstallationDetailView: View {
    @State var booking: Booking
    @ObservedObject var vm: ProvidersViewModel
    
    var body: some View {
        VStack {
            GroupBox {
                HStack {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("**Data:** \(booking.date, formatter: dateFormatter)")
                            .fontWeight(.light)
                        Text("**Telefone:** \(booking.phone)")
                            .fontWeight(.light)
                        Text("**Email:** \(booking.email)")
                            .fontWeight(.light)
                        Text("**Cidade:** \(booking.city)")
                            .fontWeight(.light)
                        Text("**Estado:** \(booking.state)")
                            .fontWeight(.light)
                    }
                    Spacer()
                    Button {
                        UIApplication.shared.open(URL(string: "sms:")!, options: [:], completionHandler: nil)
                    } label: {
                        Text("Contatar")
                    }.buttonStyle(.borderedProminent)

                }
            }
            ForEach(vm.plans, id: \.id) { plan in
                if plan.id == booking.planID {
                    GroupBox {
                        HStack {
                            VStack(alignment: .leading, spacing: 8.0) {
                                    if plan.dataCapacity != nil {
                                        Text("Franquia de dados: " + String(plan.dataCapacity!) + "GB").fontWeight(.light)
                                    }
                                    Text("Velocidade de download: " + String(plan.downloadSpeed) + "Mbps").fontWeight(.light)
                                    Text("Velocidade de upload: " + String(plan.uploadSpeed) + "Mbps").fontWeight(.light)
                                    Text("Descrição sobre o plano: " + plan.description).fontWeight(.light)
                                    Text("Preço: R$\(String(format: "%.2f", plan.pricePerMonth))").fontWeight(.light)
                                    Text("Tipo de internet: " + plan.typeOfInternet).fontWeight(.light)
                            }
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            vm.fetchPlans()
        }
        .navigationTitle(booking.name)
        .padding()
    }
}

struct InstallationDeatilView_Previews: PreviewProvider {
    static var previews: some View {
        InstallationDetailView(booking: Booking(name: "", city: "", email: "", phone: "", state: "", date: Date(), planID: 1), vm: ProvidersViewModel())
    }
}
