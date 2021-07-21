//
//  SavedCitiesView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct SavedCitiesView: View {
    
    @StateObject var citiesVM = CitiesViewModel()
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var savedCities: FetchedResults<SavedCity>
    
    @State var searchQuery = ""
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Saved Cities").font(.largeTitle.bold())
                Spacer()
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "xmark").font(.largeTitle).foregroundColor(.primary)
                })
            }
            
            SearchBar(text: $searchQuery).padding(.top)
                .onChange(of: searchQuery, perform: { query in
                    citiesVM.errMsg = ""
                    citiesVM.fetchCities(query: query)
                }).padding(.top)
            
            if searchQuery != "" {
                if citiesVM.errMsg != "" {
                    Text(citiesVM.errMsg).padding(.top)
                    Spacer()
                } else {
                    List(citiesVM.cities) { city in
                        HStack {
                            Text("\(city.address.name), \(city.address.country)")
                            Spacer()
                            Button("Add City") {
                                citiesVM.saveCity(id: city.id, name: city.address.name, country: city.address.country, lat: city.lat, lon: city.lon, viewContext: viewContext)
                                searchQuery = ""
                                // dismiss keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
                }
            } else {
                ScrollView {
                    if savedCities.isEmpty {
                        Text("No saved city.")
                    } else {
                        HStack {
                            Image(systemName: "location")
                            Text("Current Location")
                            Spacer()
                        }.font(.title2)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10.0)
                        .padding(.vertical, 5.0)
                        ForEach(savedCities) { savedCity in
                            Button(action: {
                                // load weather forcast for this city
                                weatherVM.latitude = savedCity.lat
                                weatherVM.longtitude = savedCity.lon
                                weatherVM.city = savedCity.name!
                                weatherVM.country = savedCity.country!
                                weatherVM.fetchWeather()
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                HStack {
                                    Text("\(savedCity.name!), \(savedCity.country!)")
                                    Spacer()
                                    Button(action: {
                                        if let index = savedCities.firstIndex(of: savedCity) {
                                            deleteSavedCity(offsets: IndexSet(integer: index))
                                        }
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                }
                            }).font(.title2)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10.0)
                            .padding(.vertical, 5.0)
                        }
                    }
                }.padding(.top)
            }
            
        }.padding()
        .alert(isPresented: self.$citiesVM.alertTrigger, content: {
            Alert(title: Text("Unable to save city"),
                  message: Text(citiesVM.alertMsg),
                  dismissButton: .default(Text("OK")))
        })
    }
    // delete saved city
    private func deleteSavedCity(offsets: IndexSet) {
        offsets.map { savedCities[$0] }.forEach(viewContext.delete)
        citiesVM.saveContext(context: viewContext)
    }
}

struct SavedCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCitiesView().environmentObject(WeatherViewModel())
    }
}
