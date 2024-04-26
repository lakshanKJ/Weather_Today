//
//  SplashView.swift
//  WeatherToday
//
//  Created by Kavindu Lakshan Jayathilake on 2023-04-26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var splashOver: Bool = false
    @StateObject var modelData = ModelData()
    
    var body: some View {
        ZStack {
            
            if self.splashOver {
                ContentView().environmentObject(modelData)
            } else {
                
                Rectangle()
                    .background(.black)
                
                VStack {
                    Image("storm")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                    
                    Text("Weather Today")
                        .foregroundColor(.white)
                        .font(.custom("Futura", size: 45))
                        .multilineTextAlignment(.center)
                }
            }
        }//ZStack
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.splashOver = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
