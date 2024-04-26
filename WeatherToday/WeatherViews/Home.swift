//
//  HomeView.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State var userLocation: String = ""
    @EnvironmentObject var airData: AirData
    @State private var buttonColorPrimary = Color.black
    @State private var buttonColorSecondary = Color.white
    
    
    var body: some View {
        ZStack{
            // background image variating according to the weather change
            if let weather = modelData.forecast!.current.weather {
                switch weather.first?.main {
                case .clear, .sand :
                    Image("background2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            buttonColorPrimary = Color.white
                            buttonColorSecondary = Color.black
                        }
                default:
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            buttonColorPrimary = Color.black
                            buttonColorSecondary = Color.white
                        }
                }
            } else {
                Image("background2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .font(.system(size: 25))
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 60)
                    .foregroundColor(buttonColorSecondary)
                    .shadow(color:buttonColorSecondary, radius: 0.5)
                    .background(buttonColorPrimary)
                    .cornerRadius(40)
                    .overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(buttonColorPrimary, lineWidth: 2))
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(maxHeight: 50)
                
                Text(userLocation)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                .background(.white.opacity(0.3))
                .cornerRadius(16)
                
                Spacer()
                    .frame(maxHeight: 50)
                
                VStack {
                    
                    Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPa")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    HStack {
                        
                        AsyncImage(url: modelData.forecast!.current.weather.first?.iconURL) { iconImage in
                            iconImage
                                .resizable()
                                .frame(width: 70, height: 70)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text("\(((modelData.forecast!.current.weather[0].weatherDescription).rawValue).capitalized)")
                            .fontWeight(.semibold)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                    }
                    .background(.white.opacity(0.3))
                    .cornerRadius(16)
                }
                
                
                Spacer()
            }
            .onAppear {
                Task.init {
                    
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                }
                
            }
            
            
        }//ZStack
        .font(.custom("Apple SD Gothic Neo", size: 20))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ModelData())
    }
}
