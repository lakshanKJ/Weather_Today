//
//  Forecast.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        
        VStack{
            
            Text(locationString)
                .font(.title)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 0.5)
                .multilineTextAlignment(.center)
            
            List{
                ForEach(modelData.forecast!.daily) { day in
                    DailyView(day: day)
                }
            }
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
        
        .onAppear {
            Task.init {
                
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
        }
        .background(Image("background2")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .font(.custom("Apple SD Gothic Neo", size: 20))
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
