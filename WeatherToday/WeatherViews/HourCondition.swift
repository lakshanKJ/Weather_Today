//
//  HourCondition.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct HourCondition: View {
    var current: Current
//    @State private var image: Image? = nil
    
    var body: some View {
        HStack {
            Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(current.dt ))).formatted(.dateTime.minute().hour())) \n \(Date(timeIntervalSince1970: TimeInterval((Int)(current.dt ))).formatted(.dateTime.weekday()))")
            Spacer()
            AsyncImage(url: current.weather.first?.iconURL) { iconImage in
                iconImage
                    .resizable()
                    .frame(width: 70, height: 70)
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
            
            Text("\(Int(current.temp))ºC")
            
            Text("\((current.weather[0].weatherDescription).rawValue.capitalized)")
            
            Spacer()
            
        }
        .padding()
        .font(.custom("Apple SD Gothic Neo", size: 20))
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
