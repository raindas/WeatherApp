//
//  WeatherVM.swift
//  WeatherApp
//
//  Created by President Raindas on 20/07/2021.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    private var APIKey = ""//<-- entire API key here
    
    @Published var weather: WeatherResponse
    var current: CurrentWeather
    var currentWeatherDesc: CurrentWeatherDescription
    var hourly: CurrentWeather
    var daily: DailyWeather
    var dailyWeatherTemp: DailyWeatherTemperature
    var dailyWeatherDesc: DailyWeatherDescription
    
    @Published var latitude = 0.0
    @Published var longtitude = 0.0
    
    init() {
        // create dummy data
        let dailyWeatherDescription = DailyWeatherDescription(main: "__", description: "__")
        let dailyWeatherTemperature = DailyWeatherTemperature(min: 0.0, max: 0.0)
        let daily = DailyWeather(datetime: 0, temperature: dailyWeatherTemperature, weather: [dailyWeatherDescription])
        
        let currentWeatherDescription = CurrentWeatherDescription(main: "--", description: "--")
        
        let current = CurrentWeather(datetime: 0, temperature: 0.0, feels_like: 0.0, pressure: 0, humidity: 0, visibility: 0, wind_speed: 0.0, wind_deg: 0, weather: [currentWeatherDescription])
        let hourly = current
        
        self.dailyWeatherDesc = dailyWeatherDescription
        self.dailyWeatherTemp = dailyWeatherTemperature
        self.daily = daily
        self.hourly = hourly
        self.currentWeatherDesc = currentWeatherDescription
        self.current = current
        self.weather = WeatherResponse(lat: 0.0, lon: 0.0, timezone: "", current: self.current, hourly: [self.hourly], daily: [self.daily])
    }
    
    // fetch weather forcast
    func fetchWeather() {
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=43.6532&lon=79.3832&exclude=minutely&units=metric&appid=\(APIKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        print("Weather Response -> \(decodedResponse)")
                        self.weather = decodedResponse
                    }
                    return
                } catch {
                    print("Unable to decode JSON -> \(error)")
                }
            }
            print("Weather fetch request failed: \(error?.localizedDescription ?? "Unknown Error")")
//            DispatchQueue.main.async {
//                self.errMsg = error?.localizedDescription ?? "Unknown Error"
//            }
        }.resume()
    }
}
