//
//  Hourly.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var location = ""
    
    var body: some View {
        VStack{
            
            Text(location)
                .font(.title)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 0.5)
                .multilineTextAlignment(.center)
            
            List {
                ForEach(modelData.forecast!.hourly) { hour in
                    HourCondition(current: hour)
                }
            }
            .opacity(0.8)
        }
        .onAppear{
            Task.init{
                
                self.location = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
            }
        }
        
        .background(Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .font(.custom("Apple SD Gothic Neo", size: 20))
        
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
