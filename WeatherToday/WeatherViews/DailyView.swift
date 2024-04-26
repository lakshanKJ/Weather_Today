//
//  DailyView.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct DailyView: View {
    var day : Daily
//    @State private var image: Image? = nil
   
    var body: some View {
        
        HStack {
            
            AsyncImage(url: day.weather.first?.iconURL) { iconImage in
                iconImage
                    .resizable()
                    .frame(width: 70, height: 70)
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                
                Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(day.dt ))).formatted(.dateTime.weekday().day()))")
                
            }
            Spacer()
//            high temp / low temp
            Text("\(Int(day.temp.max))ºC/ \(Int(day.temp.min))ºC")
                .padding()
           
        }
        .padding()
        .font(.custom("Apple SD Gothic Neo", size: 20))
            
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
