//
//  WeatherManager.swift
//  WeatherForecast
//
//  Created by Marlon Junior🦈⚓️ on 06/11/21.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager: WeatherManager ,weather : WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager{
    
    let fixURLWeather = "https://api.openweathermap.org/data/2.5/weather?appid=bbf02f54099f39e8ebdab6ba82de80c3&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(fixURLWeather)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(fixURLWeather)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString : String ){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError( error!)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
}
