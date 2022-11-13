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
    
    let backgroundGradient = LinearGradient(
        colors: [.indigo, .cyan],
        startPoint: .top, endPoint: .bottomTrailing)
    
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            ZStack {
                backgroundGradient.ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "filemenu.and.cursorarrow")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        Text("To Do")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.3)) {
                            self.size = 1.4
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeOut(duration: 0.5)) {
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
