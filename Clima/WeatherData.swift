struct WeatherData: Decodable {
    let list: [WeatherItem]
    let city: City
}

struct WeatherItem: Decodable {
    let main: Main
    let weather: [Weather]
}

struct City: Decodable {
    let name: String
    let coord: Coord
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
