//
//  WeatherVM.swift
//  WeatherApp
//
//  Created by President Raindas on 20/07/2021.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    private var APIKey = "dae23f6033e775a3c1fae2be07e0236e"//<-- entire API key here
    
    @Published var locationManager = LocationManager()
    
    @Published var weather: WeatherResponse
    var current: CurrentWeather
    var currentWeatherDesc: CurrentWeatherDescription
    var hourly: HourlyWeather
    var daily: DailyWeather
    var dailyWeatherTemp: DailyWeatherTemperature
    var dailyWeatherDesc: DailyWeatherDescription
    
    @Published var latitude = 0.0
    @Published var longtitude = 0.0
    @Published var city = ""
    @Published var country = ""
    
    init() {
        // create dummy data
        let dailyWeatherDescription = DailyWeatherDescription(main: "__", description: "__")
        let dailyWeatherTemperature = DailyWeatherTemperature(min: 0.0, max: 0.0)
        let daily = DailyWeather(datetime: 0, temperature: dailyWeatherTemperature, weather: [dailyWeatherDescription])
        
        let currentWeatherDescription = CurrentWeatherDescription(main: "--", description: "--")
        
        let current = CurrentWeather(datetime: 0, temperature: 0.0, feels_like: 0.0, pressure: 0, humidity: 0, visibility: 0, wind_speed: 0.0, wind_deg: 0, weather: [currentWeatherDescription])
        let hourly = HourlyWeather(datetime: 0, temperature: 0, weather: [currentWeatherDescription])
        
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
        
        // check if coordinate values are both 0.0, this means that the system should use current location coordinates.
        if self.latitude == 0.0 && self.longtitude == 0.0 {
            self.latitude = locationManager.lastLocation?.coordinate.latitude ?? 0.0
            self.longtitude = locationManager.lastLocation?.coordinate.longitude ?? 0.0
            print("lat -> \(self.latitude) | lon -> \(self.longtitude)")
            fetchCurrentCityAddress()
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longtitude)&exclude=minutely&units=metric&appid=\(APIKey)"
        
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
                        //print("Weather Response -> \(decodedResponse)")
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
    
    // fetch current city name and country
    func fetchCurrentCityAddress() {
        let CityAPIKey = CitiesViewModel().APIKey
        var currentCity = CurrentCity(address: CurrentCityAddress(city: "__", country: "__"))
        let urlString = "https://us1.locationiq.com/v1/reverse.php?key=\(CityAPIKey)&lat=\(self.latitude)&lon=\(self.longtitude)&format=json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(CurrentCity.self, from: data)
                    DispatchQueue.main.async {
                        print("Weather City Response -> \(decodedResponse)")
                        currentCity = decodedResponse
                        self.city = currentCity.address.city ?? "__"
                        self.country = currentCity.address.country ?? "__"
                        print("Weather City Response latlon -> \(self.latitude), \(self.longtitude)")
                    }
                    return
                } catch {
                    print("Unable to decode JSON -> \(error)")
                }
            }
            print("Current city fetch request failed: \(error?.localizedDescription ?? "Unknown Error")")
            //            DispatchQueue.main.async {
            //                self.errMsg = error?.localizedDescription ?? "Unknown Error"
            //            }
        }.resume()
    }
}
