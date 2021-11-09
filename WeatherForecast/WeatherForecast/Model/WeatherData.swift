//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Marlon Junior🦈⚓️ on 07/11/21.
//

import Foundation
struct  WeatherData: Codable{
    let name: String
    let main: Main
    let weather : [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let id : Int
    let main : String
    let description : String
}
