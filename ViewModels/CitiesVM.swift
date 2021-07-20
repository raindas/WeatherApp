//
//  CitiesVM.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import Foundation
import CoreData

final class CitiesViewModel: ObservableObject {
    
    @Published var cities = [CitiesModel]()
    @Published var errMsg = ""
    @Published var alertMsg = ""
    @Published var alertTrigger = false
    @Published var isLoading = false
    
    private var APIKey = "pk.fa0820725798c315ecad68416c93cd65"
    
    // fetch cities
    func fetchCities(query: String) {
        
        let urlString = "https://api.locationiq.com/v1/autocomplete.php?key=\(APIKey)&q=\(query)&tag=place%3Acity"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([CitiesModel].self, from: data)
                    DispatchQueue.main.async {
                        self.cities = decodedResponse
                    }
                    return
                } catch {
                    print("Unable to decode JSON -> \(error)")
                }
            }
            //print("Fixtures fetch request failed: \(error?.localizedDescription ?? "Unknown Error")")
            DispatchQueue.main.async {
                self.errMsg = error?.localizedDescription ?? "Unknown Error"
            }
        }.resume()
    }
    
    private func isCitySaved(context: NSManagedObjectContext, id: Int) -> Bool {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCity")
        let res = (try? context.fetch(req)) as? [NSManagedObject] ?? []
        
        let num:[Int] = res.compactMap {
            ($0.value(forKey: ("id")) as! Int)
        }
        
        if num.contains(id) {
            return true
        } else {
            return false
        }
    }
    
    func saveContext(context: NSManagedObjectContext){
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    func saveCity(id: String, name: String, country: String, lat: String, lon: String, viewContext: NSManagedObjectContext) {
        if isCitySaved(context: viewContext, id: Int(id)!) {
            // alert users about it
            self.alertMsg = "City already on Saved List."
            self.alertTrigger.toggle()
        } else {
            let newSavedCity = SavedCity(context: viewContext)
            newSavedCity.id = Int64(id)!
            newSavedCity.name = name
            newSavedCity.country = country
            newSavedCity.lat = Double(lat)!
            newSavedCity.lon = Double(lon)!
            saveContext(context: viewContext)
        }
    }
    
    func demoPrintDetails(name:String,country:String,lat:String,lon:String) {
        print("Name -> \(name)")
        print("Country -> \(country)")
        print("lat -> \(Double(lat)!)")
        print("lon -> \(Double(lon)!)")
    }
}
