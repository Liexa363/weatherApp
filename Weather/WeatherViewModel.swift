//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Liexa MacBook Pro on 21.07.2024.
//

import Foundation

class WeatherViewModel: ObservableObject, WeatherManagerDelegate {
    @Published var weather: WeatherModel?
    @Published var error: Error?

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weather = weather
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
}
