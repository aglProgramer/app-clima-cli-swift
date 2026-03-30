import Foundation

struct Coordenadas {

    static func obtener(ciudad: String) -> (Double, Double)? {
        switch ciudad.lowercased() {
        case "cucuta":
            return (7.8939, -72.5078)
        case "bogota":
            return (4.7110, -74.0721)
        case "medellin":
            return (6.2442, -75.5812)
        default:
            return nil
        }
    }
}