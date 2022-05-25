//
//  PlanDetailView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI

struct PlanDetailView: View {
    @State var plan: Plan
    @ObservedObject var vm: ProvidersViewModel
    @State private var showBookingInstallation = false
    
    var body: some View {
        ScrollView {
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
            ForEach(vm.installers, id: \.id) { installer in
                GroupBox {
                    HStack {
                        VStack(alignment: .leading, spacing: 5.0) {
                            Text("Nome: " + installer.name).fontWeight(.light)
                            Text("Nota: " + String(installer.rating)).fontWeight(.light)
                            Text("Preço por km: R$\(String(installer.pricePerKm))").fontWeight(.light)
                        }
                        Spacer()
                        Button {
                            showBookingInstallation = true
                        } label: {
                            Text("Contratar Plano")
                        }
                        .buttonStyle(.borderedProminent)
                        .sheet(isPresented: $showBookingInstallation) {
                            BookingInstallationView(showBookingInstallation: $showBookingInstallation, plan: plan)
                        }
                    }
                    
                }
            }
        }
        .padding()
        .task {
            vm.fetchInstaller(planID: plan.id)
        }
        .navigationTitle(plan.isp)
    }
}


struct PlanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanDetailView(plan: Plan(id: 1, isp: "", downloadSpeed: 0, uploadSpeed: 0, description: "", pricePerMonth: 0, typeOfInternet: ""), vm: ProvidersViewModel())
    }
}
