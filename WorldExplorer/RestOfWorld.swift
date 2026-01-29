//
//  RestOfWorld.swift
//  WorldExplorer
//
//  Created by Kiran Shrestha on 1/29/26.
//

import Foundation

@Observable
class RestOfWorld : Codable {
    enum Regions : String, CaseIterable {
        case africa = "africa"
        case americas = "americas"
        case asia = "asia"
        case europe = "europe"
        case oceania = "oceania"
    }
    
    struct Country : Codable, Identifiable {
        let id = UUID().uuidString
        var name : CountryNames
        var region : String
        var capital : [String]?
        var flags : Flags
        var coatOfArms : CoatOfArms
        
        enum CodingKeys: CodingKey {
            case name
            case region
            case capital
            case flags
            case coatOfArms
        }
    }
    struct CountryNames : Codable {
        var common : String
        var official : String
    }
    
    struct Flags : Codable {
        var png : String
        var svg : String
        var alt : String?
    }
    
    struct CoatOfArms : Codable {
        var png : String?
        var svg : String?
    }
    
    var countries : [Country] = []
    
    func getData(of continent : Regions) async {
        guard let url = URL(string: "https://restcountries.com/v3.1/region/\(continent.rawValue)") else { return }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let returned = try JSONDecoder().decode(Array<Country>.self, from: data)
            countries = returned
        } catch {
            print("😡 Error! \n\(error) \n😡 END")
        }
    }
}
