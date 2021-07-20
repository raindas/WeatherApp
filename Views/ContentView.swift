//
//  ContentView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingNext7Days = false
    @State private var isShowingCitiesView = false
    @State private var isShowingPreferencesView = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Lagos,").bold()
                            Text("Nigeria").foregroundColor(.secondary)
                        }.font(.largeTitle)
                        
                        HStack {
                            Text("Monday,").font(.title3).foregroundColor(.secondary)
                            Text(Date(), style: .time).font(.title3).foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    Menu {
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
                Text("28º").bold().font(.system(size: 70))
                Text("Partly Cloudy").font(.title2).foregroundColor(.secondary)
                
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
                            Text("29º").font(.title)
                            Divider()
                            Text("Visibility").foregroundColor(.secondary)
                            Text("3").font(.title)
                            Text("Km").font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Pressure").foregroundColor(.secondary)
                            Text("60").font(.title)
                            Text("mmHg").font(.footnote)
                            Divider()
                            Text("Wind Speed").foregroundColor(.secondary)
                            Text("15").font(.title)
                            Text("Km/h").font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Humidity").foregroundColor(.secondary)
                            Text("29%").font(.title)
                            Divider()
                            Text("Wind Degree").foregroundColor(.secondary)
                            Text("12º").font(.title)
                        }
                    }.padding(.vertical)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(1..<10) {
                                _ in
                                VStack {
                                    Text(Date(), style: .time).padding(5)
                                    Image(systemName: "cloud.sun.fill").font(.largeTitle).padding(5)
                                    Text("28º").font(.largeTitle).padding(5)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
