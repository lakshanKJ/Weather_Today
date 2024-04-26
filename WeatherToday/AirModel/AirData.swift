//
//  AirData.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import Foundation

class AirData: ObservableObject {
    @Published var currentAirPollution: CurrentAirPollution?
    
    init() {
        self.currentAirPollution = load("londonAirPollution.json")
    }
    
    
    func loadData(lat: Double, lon: Double) async throws -> CurrentAirPollution {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=b432020e77acb54deb5621730e1efbff")
        print("API REQUEST - \(url?.absoluteString ?? "NO VALUE")")
        
        let session = URLSession(configuration: .default)
        
        do {
            let (data, _) = try await session.data(from: url!)
            //print(data)
            let currentAirPollutionData = try JSONDecoder().decode(CurrentAirPollution.self, from: data)
            DispatchQueue.main.async {
                self.currentAirPollution = currentAirPollutionData
            }
            
            return currentAirPollutionData
        } catch {
            throw NetworkError.requestFailed(error: error)
        }
    }
    
    func load<CurrentAirPollution: Decodable>(_ filename:String) -> CurrentAirPollution {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CurrentAirPollution.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(CurrentAirPollution.self):\n\(error)")
        }
    }
}
