//
//  NavBar.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct NavBar: View {
    
    @StateObject var airData = AirData()
    
    var body: some View {
        TabView{
           Home()
                .tabItem{
                    Label("City", systemImage: "magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    Label("WeatherNow", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    Label("HourlyView", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    Label("ForecastView", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    Label("PollutionView", systemImage: "aqi.high")
                }
                .environmentObject(airData)
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        .environmentObject(airData)
        
    }
        
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}

