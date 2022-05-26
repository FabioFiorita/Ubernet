//
//  Providers.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import Foundation
import CoreLocation

struct Plan: Codable {
    var id: Int
    var isp: String
    var dataCapacity: Int?
    var downloadSpeed: Double
    var uploadSpeed: Double
    var description: String
    var pricePerMonth: Double
    var typeOfInternet: String
}
struct Installer: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var rating: Int
    var pricePerKm: Int
    var lat: Double
    var lng: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
struct User {
    var name: String
    var city: String
    var email: String
    var phone: String
    var state: String
    var installer: Bool
}

struct Booking: Hashable {
    var name: String
    var city: String
    var email: String
    var phone: String
    var state: String
    var date: Date
    var planID: Int
}

var states = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MS",
    "MT",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO",
]

let dateFormatter: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateStyle = .full
         formatter.timeStyle = .short
         //formatter.locale = Locale(identifier: "pt-BR")
         return formatter
     }()
