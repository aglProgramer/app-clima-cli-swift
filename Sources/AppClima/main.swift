import Foundation

let service = WeatherService()

print("🌤️ App Clima CLI")
print("----------------------")

print("Ingresa tu ciudad:")

if let ciudad = readLine() {
    
    let ciudadLimpia = ciudad.trimmingCharacters(in: .whitespacesAndNewlines)

    if ciudadLimpia.isEmpty {
        print("❌ Ciudad inválida")
        exit(0)
    }

    if let (lat, lon) = Coordenadas.obtener(ciudad: ciudadLimpia) {
        
        let semaphore = DispatchSemaphore(value: 0)

        service.fetchWeather(lat: lat, lon: lon) { clima in
            
            if let clima = clima {
                print("📍 \(ciudadLimpia)")
                print("🌡️ Temperatura: \(clima.current_weather.temperature)°C")
                print("💨 Viento: \(clima.current_weather.windspeed) km/h")
            } else {
                print("❌ No se pudo obtener el clima")
            }

            semaphore.signal()
        }

        semaphore.wait()

    } else {
        print("❌ No tenemos datos de esa ciudad aún")
    }

} else {
    print("❌ Error al leer ciudad")
}