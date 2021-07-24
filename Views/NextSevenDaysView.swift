//
//  NextSevenDaysView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct NextSevenDaysView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let city: String
    let country: String
    let dailyWeather: [DailyWeather]
    
    let dateTimeManager = DateTimeManager()
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left").foregroundColor(.primary)
                })
                Spacer()
                Group {
                    Text("\(self.city),")
                    Text(self.country).foregroundColor(.secondary)
                }.minimumScaleFactor(0.01)
                .lineLimit(1)
                Spacer()
            }.font(.title)
            
            
            HStack {
                Text("Next 7 Days").font(.title.bold())
                Spacer()
            }.padding(.top)
            
            // next 7 days forcast
            ForEach(self.dailyWeather.prefix(7)) { day in
                HStack {
                    Image(systemName: weatherVM.iconMap[day.main] ?? weatherVM.defaultIcon)
                    Spacer()
                    Text(dateTimeManager.epochToDayDate(timestamp: day.datetime)).minimumScaleFactor(0.01)
                        .lineLimit(1)
                    Spacer()
                    Text("\(String(format: "%.0f", day.temperature.max) == "0" ? "__" : "\(String(format: "%.0f", day.temperature.max) )")º")
                    Text("/").foregroundColor(.secondary)
                    Text("\(String(format: "%.0f", day.temperature.min) == "0" ? "__" : "\(String(format: "%.0f", day.temperature.min) )")º").font(.title2).foregroundColor(.secondary)
                }.font(.title).padding(.vertical)
            }
            
            Spacer()
            
        }.padding()
    }
}

struct NextSevenDaysView_Previews: PreviewProvider {
    static var previews: some View {
        NextSevenDaysView(city: "City", country: "Country", dailyWeather: [DailyWeather(datetime: 0, temperature: DailyWeatherTemperature(min: 0.0, max: 0.0), weather: [CurrentWeatherDescription(main: "", description: "")])]).environmentObject(WeatherViewModel())
    }
}
