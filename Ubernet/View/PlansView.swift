//
//  FormView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI

struct PlansView: View {
    @ObservedObject var vm: ProvidersViewModel
    @EnvironmentObject var fbManager: FirebaseManager
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            List {
                Section("Provedores do estado de \(fbManager.user?.state ?? "")") {
                    ForEach(vm.plans, id: \.id) { plan in
                        NavigationLink(destination: PlanDetailView(plan: plan, vm: vm)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(plan.isp)
                                    .font(.title)
                                Text("Preço: R$\(String(format: "%.2f", plan.pricePerMonth))")
                                    .fontWeight(.light)
                                Text("Tipo: \(plan.typeOfInternet)")
                                    .fontWeight(.light)
                            }
                        }
                    }
                }
            }
            .refreshable {
                vm.fetchPlan(state: fbManager.user?.state ?? "MG")
            }
            .task {
                vm.fetchPlan(state: fbManager.user?.state ?? "MG")
            }
            .navigationTitle("Provedores")
            .toolbar {
                ToolbarItem {
                    Button {
                        fbManager.signOut()
                    } label: {
                        Text("Deslogar")
                    }
                    
                }
        }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView(vm: ProvidersViewModel())
    }
}
