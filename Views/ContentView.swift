//
//  ContentView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    @State private var isShowingNext7Days = false
    @State private var isShowingCitiesView = false
    @State private var isShowingPreferencesView = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(weatherVM.city == "" ? "City" : weatherVM.city),").bold()
                            Text(weatherVM.country == "" ? "Country" : weatherVM.country).foregroundColor(.secondary)
                        }.font(.largeTitle)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        
                        HStack {
                            Text("Monday,")
                            Text(Date(), style: .time)
                        }.font(.title3).foregroundColor(.secondary)
                    }
                    Spacer()
                    Menu {
                        Button(action: {
                            weatherVM.latitude = 0.0
                            weatherVM.longtitude = 0.0
                            weatherVM.city = ""
                            weatherVM.country = ""
                            weatherVM.fetchWeather()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                            Text("Refresh Weather Data")
                        })
                        Button(action: {isShowingCitiesView.toggle()}, label: {
                            Image(systemName: "list.dash")
                            Text("Saved Cities")
                        })
                        Button(action: {isShowingPreferencesView.toggle()}, label: {
                            Image(systemName: "gearshape.fill")
                            Text("Preferences")
                        })
                    } label: {
                        Image(systemName: "ellipsis").font(.largeTitle).foregroundColor(.primary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "cloud.sun.fill").font(.system(size: 70))
                Text("\(String(format: "%.0f", weatherVM.weather.current.temperature) == "0" ? "__" : "\(String(format: "%.0f", (weatherVM.weather.current.temperature)) )")º").bold().font(.system(size: 70))
                Text(weatherVM.weather.current.weatherDescription).font(.title2).foregroundColor(.secondary)
                
                Spacer()
                
                VStack {
                    
                    NavigationLink("",destination:NextSevenDaysView().navigationBarBackButtonHidden(true).navigationBarHidden(true),isActive: $isShowingNext7Days)
                    
                    HStack {
                        Text("Today")
                        Spacer()
                        Button(action: {isShowingNext7Days.toggle()}, label: {
                            Text("Next 7 Days")
                            Image(systemName: "chevron.right")
                        }).foregroundColor(.secondary)
                    }.font(.title3)
                    
                    HStack(alignment: .top) {
                        VStack {
                            Text("Feels Like").foregroundColor(.secondary)
                            Text("\(String(format: "%.0f", weatherVM.weather.current.feels_like) == "0" ? "__" : String(format: "%.0f", weatherVM.weather.current.feels_like))º").font(.title)
                            Divider()
                            Text("Visibility").foregroundColor(.secondary)
                            Text("\(weatherVM.weather.current.visibility)").font(.title)
                            Text("Km").font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Pressure").foregroundColor(.secondary)
                            Text("\(weatherVM.weather.current.pressure)").font(.title)
                            Text("mmHg").font(.footnote)
                            Divider()
                            Text("Wind Speed").foregroundColor(.secondary)
                            Text("\(String(format: "%.0f", weatherVM.weather.current.wind_speed) == "0" ? "__" : String(format: "%.0f", weatherVM.weather.current.wind_speed))").font(.title)
                            Text("Km/h").font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Humidity").foregroundColor(.secondary)
                            Text("\(weatherVM.weather.current.humidity)%").font(.title)
                            Divider()
                            Text("Wind Degree").foregroundColor(.secondary)
                            Text("\(weatherVM.weather.current.wind_deg)º").font(.title)
                        }
                    }.padding(.vertical)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(weatherVM.weather.hourly) {
                                hour in
                                VStack {
                                    Text(Date(), style: .time).padding(5)
                                    Image(systemName: "cloud.sun.fill").font(.largeTitle).padding(5)
                                    Text("\(String(format: "%.0f", hour.temperature) == "0" ? "__" : String(format: "%.0f", hour.temperature))º").font(.largeTitle).padding(5)
                                }.padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(Color.secondary, lineWidth: 1)
                                )
                            }
                        }
                    }
                    
                }.padding(20)
                .background(Color(.systemGray6))
                .cornerRadius(10.0)
                
            }.padding()
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isShowingCitiesView, content: {
                SavedCitiesView()
            })
            .fullScreenCover(isPresented: $isShowingPreferencesView, content: {
                PreferencesView()
            })
        }.onAppear {
            weatherVM.fetchWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WeatherViewModel())
        
    }
}
