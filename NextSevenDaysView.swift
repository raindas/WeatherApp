//
//  NextSevenDaysView.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

struct NextSevenDaysView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left").foregroundColor(.primary)
                })
                Spacer()
                Text("Lagos,")
                Text("Nigeria").foregroundColor(.secondary)
                Spacer()
            }.font(.title)
            
            
            HStack {
                Text("Next 7 Days").font(.title.bold())
                Spacer()
            }.padding(.top)
            
            // next 7 days forcast
            ForEach(1..<8) { _ in
                HStack {
                    Image(systemName: "sun.max.fill")
                    Spacer()
                    Text("Tuesday, 20 Jul")
                    Spacer()
                    Text("32º")
                    Text("/").foregroundColor(.secondary)
                    Text("31º").font(.title2).foregroundColor(.secondary)
                }.font(.title).padding(.vertical)
            }
            
            Spacer()
            
        }.padding()
    }
}

struct NextSevenDaysView_Previews: PreviewProvider {
    static var previews: some View {
        NextSevenDaysView()
            
    }
}
