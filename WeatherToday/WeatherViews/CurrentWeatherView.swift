//
//  Conditions.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    @State private var imageSunrise: Image? = nil
    
    var body: some View {
        ZStack {
            
            // background image variating according to the weather change
            if let weather = modelData.forecast!.current.weather {
                switch weather.first?.main {
                case .clear, .sand :
                    Image("background2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                default:
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
            } else {
                Image("background2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
            
            
            VStack {
                
                Text(locationString)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                VStack{
                    
                    //  Temperature Info
                    VStack {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        
                        HStack {
                            
                            AsyncImage(url: modelData.forecast!.current.weather.first?.iconURL) { iconImage in
                                iconImage
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                                .padding()
                                .fontWeight(.semibold)
                        }
                        .background(.white.opacity(0.3))
                        .cornerRadius(16)
                        
                        HStack {
                            Text("H: \((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                                .padding()
                            Text("Low: \((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                                .padding()
                        }
                        
                        Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)
                        
                        HStack {
                            Text("Wind Speed : \(Int(modelData.forecast!.current.windSpeed)) m/s")
                                .foregroundColor(.black)
                            Text("Direction : \(convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .padding()
                        .multilineTextAlignment(.leading)
                        
                        HStack {
                            Text("Humidity : \(modelData.forecast!.current.humidity) %")
                                .foregroundColor(.black)
                            Text("Pressure : \(modelData.forecast!.current.pressure) hPg")
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                        HStack {
                            Image(systemName: "sunrise.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 30)
                                .foregroundColor(Color.yellow)
                            
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0))))
                                .formatted(.dateTime.hour().minute()))
                            
                            Image(systemName: "sunset.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 30)
                                .foregroundColor(Color.yellow)
                                .padding()
                            
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0))))
                                .formatted(.dateTime.hour().minute()))
                        }
                        
                    }.padding()
                    
                    
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(radius: 0.5)
            
        }//ZStack
        .onAppear {
            Task.init {
                
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
        }//ZStack
        .font(.custom("Apple SD Gothic Neo", size: 20))
        
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
