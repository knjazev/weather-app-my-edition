//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by UPIT on 12.08.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Weather App")
                .font(.largeTitle)
            
            TextField("City", text: self.$model.city)
                .autocapitalization(.words)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                )
                .accentColor(.blue)
            
            Text(
                model.currentWeather.list?[0].main?.temp != nil ?
                    "temperature: \(Int((model.currentWeather.list?[0].main?.temp!)!)) ºC"
                    : " ")
            Text(
                model.currentWeather.list?[0].main?.humidity != nil ?
                    "humidity: \(Int((model.currentWeather.list?[0].main?.humidity!)!)) %"
                    : " ")
            Text(
                model.currentWeather.list?[0].main?.pressure != nil ?
                    "pressure: \(Int((model.currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : " ")
            Image(systemName: "\(model.getweatherConditionName(weatherConditionID: model.currentWeather.list?[0].weather?[0].id! ?? 800))")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
            Button(action: {
                UITraitCollection.init(userInterfaceStyle: .dark)
            }, label: {
                Text("Mode")
            })
            
           
            Spacer()
            
        }
        .font(.title)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
    }
}
