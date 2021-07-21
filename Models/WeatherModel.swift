//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by President Raindas on 20/07/2021.
//

import Foundation

struct WeatherResponse: Decodable {
    var lat: Double
    var lon: Double
    var timezone: String
    var current: CurrentWeather
    var hourly: [HourlyWeather]
    var daily: [DailyWeather]
}

struct CurrentWeather: Decodable {
    var datetime: Int
    var temperature: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var visibility: Int
    var wind_speed: Double
    var wind_deg: Int
    var weather: [CurrentWeatherDescription]
    var weatherMain: String {
        var main = ""
        for value in weather {
            main = value.main
        }
        return main
    }
    var weatherDescription: String {
        var desc = ""
        for value in weather {
            desc = value.description
        }
        return desc
    }
    
    enum CodingKeys: String, CodingKey {
        case datetime = "dt"
        case temperature = "temp"
        case feels_like, pressure, humidity, visibility, wind_speed, wind_deg, weather
    }
}

struct CurrentWeatherDescription: Decodable {
    var main: String
    var description: String
}

struct HourlyWeather: Decodable, Identifiable {
    var id = UUID()
    var datetime: Int
    var temperature: Double
    var weather: [CurrentWeatherDescription]
    var main: String {
        var main = ""
        for value in weather {
            main = value.main
        }
        return main
    }
    
    enum CodingKeys: String, CodingKey {
        case datetime = "dt"
        case temperature = "temp"
        case weather
    }
}

struct DailyWeather: Decodable {
    var datetime: Int
    var temperature: DailyWeatherTemperature
    var weather: [DailyWeatherDescription]
    
    enum CodingKeys: String, CodingKey {
        case datetime = "dt"
        case temperature = "temp"
        case weather
    }
}

struct DailyWeatherTemperature: Decodable {
    var min: Double
    var max: Double
}

struct DailyWeatherDescription: Decodable {
    var main: String
    var description: String
}
