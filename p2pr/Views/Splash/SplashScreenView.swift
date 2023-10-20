//
//  SplashScreenView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import SwiftUI

struct SplashScreenView: View {
    static let tag = "SplashScreenView"
    
    @State private var isActive = false
    @State private var opacity = 0.8
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Text("app-name")
                        .font(.custom("red_hat_display_black", size: 38))
                        .fontWeight(.bold)
                        .padding()
                    Image("PlaceToPayIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 20)
                        .padding()
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.9)) {
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview(
) {
    SplashScreenView()
}
