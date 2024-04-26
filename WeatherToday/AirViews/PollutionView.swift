//
//  PollutionView.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var airData: AirData
    @State private var stringLocation = "No Location"
    @EnvironmentObject var modelData: ModelData
//    @State private var image:Image? = nil
    
    var body: some View {
        
        ZStack {
            
            // Use ZStack for background images
            
            VStack {
                
                Text(stringLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text("\(Int(modelData.forecast!.current.temp))ºC")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack{
                    AsyncImage(url: modelData.forecast!.current.weather.first?.iconURL) { iconImage in
                        iconImage
                            .resizable()
                            .frame(width: 70, height: 70)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                }
                HStack {
                    Text("H: \((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                        .padding()
                    Text("Low: \((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                        .padding()
                }
                
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .foregroundColor(.black)
                
                Text("Air Quality Data:")
                    .font(Font.title.weight(.medium))
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack{
                    VStack{
                        Image("so2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80)
                        Text("\(String(format: "%.2f", airData.currentAirPollution?.list[0].components.so2 ?? 0))")
                    }
                    VStack{
                        Image("no")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80)
                        Text("\(String(format: "%.2f", airData.currentAirPollution?.list[0].components.no ?? 0))")
                    }
                    VStack{
                        Image("voc")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80)
                        Text("\(String(format: "%.2f", airData.currentAirPollution?.list[0].components.co ?? 0))")
                    }
                    VStack{
                        Image("pm")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80)
                        Text("\(String(format: "%.2f", airData.currentAirPollution?.list[0].components.pm2_5 ?? 0))")
                    }
                }
                
            }
            .padding()
            
            
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .onAppear {
            Task.init {
                    
                self.stringLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
            }
            
        }
        .ignoresSafeArea(edges: [.top, .trailing, .leading])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .font(.custom("Apple SD Gothic Neo", size: 20))
    }
}

struct Pollution_Previews: PreviewProvider {
    static var previews: some View {
        PollutionView().environmentObject(AirData())
            .environmentObject(ModelData())
    }
    
}



