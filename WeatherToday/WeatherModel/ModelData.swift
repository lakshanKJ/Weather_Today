//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import Foundation

class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published  var userLocation: String = ""
    init() {
        self.forecast = load("london.json")
    }
    

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=b432020e77acb54deb5621730e1efbff")
        print("API REQUEST - \(url?.absoluteString ?? "NO VALUE")")
        let session = URLSession(configuration: .default)
        
        do {
            let (data, _) = try await session.data(from: url!)
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            throw NetworkError.requestFailed(error: error)
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
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
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(error: Error)
}
