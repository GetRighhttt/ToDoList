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
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                VStack {
                    VStack {
                        Image(systemName: "list.clipboard")
                            .font(.system(size: 40))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            self.size = 2.8
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
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
