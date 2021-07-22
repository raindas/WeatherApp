//
//  PreferencesView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct PreferencesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var metric = true
    
    var body: some View {
        VStack{
            
            HStack {
                Text("Preferences").font(.largeTitle.bold())
                Spacer()
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "xmark").font(.largeTitle).foregroundColor(.primary)
                })
            }
            
            Form {
                Section {
                    Toggle("Use metric unit system", isOn: $metric)
                }
            }
            
        }.padding()
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
