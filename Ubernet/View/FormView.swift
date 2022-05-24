//
//  FormView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI

struct FormView: View {
    @State private var state = "MG"
    @StateObject var vm = ProvidersViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Picker("Selecione o Estado", selection: $state) {
                    ForEach(states, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                Button {
                    vm.fetchPlan(state: state)
                } label: {
                    Text("Procurar")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(10.0)
                        .foregroundColor(.white)
                }
                ForEach(vm.plans, id: \.id) { plan in
                    NavigationLink(plan.isp) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Nome: \(plan.isp)")
                                .font(.title)
                            Text("Preço: R$\(String(format: "%.2f", plan.pricePerMonth))")
                                .fontWeight(.light)
                            Text("Tipo: \(plan.typeOfInternet)")
                                .fontWeight(.light)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Provedores")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
