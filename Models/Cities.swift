//
//  Cities.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import Foundation

struct CitiesModel: Codable, Identifiable {
    var id: String
    var lat: String
    var lon: String
    var address: Address
    
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case lat,lon,address
    }
}

struct Address: Codable, Equatable {
    var name: String
    var country: String
}

struct CurrentCity: Decodable {
    var address: CurrentCityAddress
}

struct CurrentCityAddress: Decodable {
    var city: String?
    var country: String?
}
