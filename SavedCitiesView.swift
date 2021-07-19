//
//  SavedCitiesView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct SavedCitiesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            
            SearchBar(text: $searchQuery).onChange(of: searchQuery, perform: { query in
                // function to perform query search
            }).padding(.top)
            
            ScrollView {
                ForEach(1..<4) { _ in
                    HStack {
                        Text("Lagos, Nigeria")
                        Spacer()
                        Image(systemName: "trash")
                    }.font(.title2)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10.0)
                    .padding(.vertical, 5.0)
                }
            }.padding(.top)
            
        }.padding()
    }
}

struct SavedCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCitiesView()
    }
}
