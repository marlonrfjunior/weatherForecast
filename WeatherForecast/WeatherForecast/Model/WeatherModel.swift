//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by Marlon Junior🦈⚓️ on 08/11/21.
//

import Foundation
struct WeatherModel{
    let   conditionId: Int
    let   cityName: String
    let   temperature: Double
    
    struct myStruct{}
    var temperatureFString : String {
        let temp = (temperature * 9/5) + 32
        return String(format: "%.1f", temp)
    }
    var temperatureKString : String {
        let temp = temperature  + 273.15
        return String(format: "%.1f", temp )
    }
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        switch(conditionId){
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud"
        case 800:
            return "sun.max"
        case 801...884:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    


}
