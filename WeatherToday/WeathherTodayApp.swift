//
//  WeatherTodayApp.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//
import SwiftUI

@main
struct WeatherTodayApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(modelData)
            SplashView()
        }
    }
}
