//
//  LocationListModel.swift
//  Spacial OClock
//
//  Created by cqlios1 on 29/08/23.
//

//import Foundation
//
//// MARK: - LocationList
//struct LocationList: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: [LocationListBody]?
//}
//
//// MARK: - Body
//struct LocationListBody: Codable {
//    var country: String?
//    var states: [State]?
//}
//
//// MARK: - State
//struct State: Codable {
//    var state: String?
//    var cities: [City]?
//}
//
//// MARK: - City
//struct City: Codable {
//    var city: String?
//    var location: [Location]?
//}
//
//// MARK: - Location
//struct Location: Codable {
//    var name: String?
//}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct LocationList: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [LocationListBody]?
}

// MARK: - LocationListBody
struct LocationListBody: Codable {
    var country,flag_image: String?
    var restaurants: [Restaurant]?
    
    enum CodingKeys: String, CodingKey {
        case country, restaurants,flag_image
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flag_image = try container.decodeIfPresent(String.self, forKey: .flag_image)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.restaurants = try container.decodeIfPresent([Restaurant].self, forKey: .restaurants)
    }
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var state, city, localityArea: String?
    var image: String?
    var timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case state, city
        case localityArea = "locality_area"
        case image,timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.localityArea = try container.decodeIfPresent(String.self, forKey: .localityArea)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
    }
}


// MARK: - LocationListModel
struct LocationListModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [LocationList_Body]?
}

// MARK: - LocationList_Body
struct LocationList_Body: Codable {
    var country: String?
    var flag_image : String?
    var states: [State]?
    var isSelected : Bool? = false
}

// MARK: - State
struct State: Codable {
    var state: String?
    var cities: [City]?
    var isSelected : Bool? = false
}

// MARK: - City
struct City: Codable {
    var city, latitude, longitude: String?
    var localityAreas: [String]?

    enum CodingKeys: String, CodingKey {
        case city, longitude, latitude
        case localityAreas = "locality_areas"
    }
}
