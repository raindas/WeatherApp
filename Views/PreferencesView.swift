//
//  PreferencesView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct PreferencesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    var body: some View {
        NavigationView {
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
                        Picker("Unit", selection: self.$weatherVM.unit) {
                            Text("Default (K)").tag("default")
                            Text("Metric (C)").tag("metric")
                            Text("Imperial (F)").tag("imperial")
                        }.onChange(of: self.weatherVM.unit, perform: { _ in
                            self.weatherVM.changeUnit()
                        })
                    }
                }
                
            }.padding().navigationBarHidden(true)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView().environmentObject(WeatherViewModel())
    }
}
