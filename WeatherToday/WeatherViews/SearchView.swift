//
//  SearchView.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var airData: AirData
    
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    @State var alert = false
    @State var errorNote = ""
    
    var body: some View {
        Spacer()
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                    
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in

                        //show alert if error has occured
                        if ((error) != nil) {
                            print("======================")
                            print("Error message \(String(describing: error?.localizedDescription))")
                            if let nsError = error as NSError?, nsError.domain == kCLErrorDomain {
                                    switch nsError.code {
                                    case CLError.network.rawValue:
                                        errorNote = "Please check your internet connection and try again"
                                    case CLError.locationUnknown.rawValue:
                                        errorNote = "The location could not be found. Try again later"
                                    case CLError.geocodeFoundNoResult.rawValue:
                                        errorNote = "Location does not exist. Try checking the spellings"
                                    default:
                                        errorNote = "An error has been occured while determining your location. Try again later"
                                    }
                            }
                            //assign true to alert variable
                            alert.toggle()
                            
                        }
                        
                        
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {

                            print("latitude: \(lat)")
                            print("longitude: \(lon)")
                            print("location: \(location)")
                            print("prior userLocation: \(userLocation)")
                            
                            Task {
                                do {
                                    let forecast = try await modelData.loadData(lat: lat, lon: lon)
                                    
                                    print("forecast successful - \(forecast)")
                                    
                                    let airDetails = try await airData.loadData(lat: lat, lon: lon)
                                    
                                    print("airDetails successful - \(airDetails)")
                                    self.userLocation = self.location
                                } catch {
                                    print("Error: \(error)")
                                }
                            }
                            
                            isSearchOpen.toggle()
                        }
                        
                    }//GEOCorder
                } //Commit
                          
                )// TextField
                .padding(10)
                .foregroundColor(.black)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
            }//VStak
            
            
        }// Zstack
        
        .alert(errorNote, isPresented: $alert){
            Button("OK") {
                //
            }
        }
        Spacer()
    }// Some
    
} //View
