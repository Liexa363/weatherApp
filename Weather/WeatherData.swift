//
//  WeatherData.swift
//  Weather
//
//  Created by Liexa MacBook Pro on 21.07.2024.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
