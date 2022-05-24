//
//  Providers.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import Foundation

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
struct Installer: Codable {
    var id: Int
    var name: String
    var rating: Int
    var pricePerKm: Int
    var lat: Double
    var lng: Double
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
