//
//  AlertView.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
            
            Button(action: action) {
                Text(buttonTitle)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}
