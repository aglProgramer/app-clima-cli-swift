import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class WeatherService {

    func fetchWeather(lat: Double, lon: Double, completion: @escaping @Sendable (ClimaResponse?) -> Void) {
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true"
        
        print("📡 [REQUEST] Consultando servidor...")

        guard let url = URL(string: urlString) else {
            print("❌ URL inválida")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ No hay datos")
                completion(nil)
                return
            }

            do {
                let clima = try JSONDecoder().decode(ClimaResponse.self, from: data)
                completion(clima)
            } catch {
                print("❌ Error al parsear JSON")
                completion(nil)
            }
        }

        task.resume()
    }
}