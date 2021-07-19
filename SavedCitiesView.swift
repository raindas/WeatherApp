//
//  SavedCitiesView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct SavedCitiesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Text("Saved Cities View")
        Button("Dismiss"){
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SavedCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCitiesView()
    }
}
