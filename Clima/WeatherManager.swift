import Foundation

protocol weatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    var delegate: weatherManagerDelegate? // Delegate acts as a communicator
    // just like waiter in a restaurent
    
    
    let weatherURL = Secrets.openWeatherMapApiKey
    
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(
                with: url){
                    (data, response, error) in
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        if let weather = self.parseJSON(weatherData: safeData) {
                            self.delegate?
                                .didUpdateWeather(self, weather: weather)
                        }
                    }
                } // <- The { ... } block is a completion handler — Swift runs this code when the response is received from the internet (like when the weather API replies).
            
            //  A completion handler is a block of code (usually a function) that runs after a task finishes — like after a network call, animation, or file download.
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.list[0].weather[0].id
            let name = decodedData.city.name
            let temp = decodedData.list[0].main.temp
            let weather = WeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp
            )
            
            print(weather.temperatureString)
            return weather
            
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
