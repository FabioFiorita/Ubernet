//
//  InstallersView.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 25/05/22.
//

import SwiftUI
import MapKit


struct InstallersMapView: View {
    @ObservedObject var vm: ProvidersViewModel
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -11.613234, longitude: -52.209981), span: MKCoordinateSpan(latitudeDelta: 21, longitudeDelta: 21))
    @State private var selectedPlace: Installer?
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: vm.installers) { installer in
                    MapAnnotation(coordinate: installer.coordinate) {
                        VStack {
                            Image(systemName: "person.crop.square.fill")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 32, height: 32)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .onTapGesture {
                            selectedPlace = installer
                            vm.fetchPlan(installerID: installer.id)
                        }
                    }
                }
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 16, height: 16)
            }
            .sheet(item: $selectedPlace, content: { installer in
                ScrollView {
                    VStack(alignment: .center, spacing: 5.0) {
                        GroupBox {
                            HStack {
                                VStack(alignment: .leading) {
                                    Image(systemName: "person.crop.square.fill")
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(Circle())
                                    Text(installer.name)
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                    Text("Nota: " + String(installer.rating)).fontWeight(.light)
                                    Text("Preço por km: R$\(String(installer.pricePerKm))").fontWeight(.light)
                                }
                                Spacer()
                                Button {
                                    UIApplication.shared.open(URL(string: "sms:")!, options: [:], completionHandler: nil)
                                } label: {
                                    Text("Contatar Instalador")
                                }.buttonStyle(.borderedProminent)
                            }
                            
                        }
                        
                    }
                    ForEach(vm.plans, id: \.id) { plan in
                        GroupBox {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(plan.isp)
                                        .font(.title)
                                    Text("Preço: R$\(String(format: "%.2f", plan.pricePerMonth))")
                                        .fontWeight(.light)
                                    Text("Tipo: \(plan.typeOfInternet)")
                                        .fontWeight(.light)
                                }
                                Spacer()
                                Button {
                                    print("Contratar")
                                } label: {
                                    Text("Contratar Plano")
                                }.buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
                .padding()
            })
            .task {
                vm.fetchInstallers()
            }
            .navigationTitle("Instaladores")
        }
    }
}

struct InstallersMapView_Previews: PreviewProvider {
    static var previews: some View {
        InstallersMapView(vm: ProvidersViewModel())
    }
}
