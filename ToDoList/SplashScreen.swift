//
//  SplashScreen.swift
//  ToDoList
//
//  Created by Stefan Bayne on 11/13/22.
//

import SwiftUI

struct SplashScreen: View {
    
    
    /*
     Tells wether splashscreen is active or not
     */
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var isRotated = false
    
    var animation: Animation {
        Animation.easeOut
    }
    
    let backgroundGradient = LinearGradient(
        colors: [.black, .white],
        startPoint: .top, endPoint: .bottomTrailing)
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                backgroundGradient.ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "bolt")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        Text("DO IT!")
                            .font(Font.custom("Baskerville-Bold", size: 16))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.9)) {
                            self.size = 2.8
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.8)) {
                            self.isActive = true
                        }
                        self.isActive = true
                    }
                }
            }
            
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
