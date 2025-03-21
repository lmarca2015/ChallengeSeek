//
//  BiometricAuthView.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI

struct BiometricAuthView: View {
    
    @ObservedObject var models = Models()
    var events = Events()
    
    var body: some View {
        VStack {
            
            if !models.errorMessage.isEmpty {
                Text(models.errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                events.onAuthenticateUserTapped?()
            }) {
                HStack {
                    Image("care_ic_face_id", bundle: .core)
                    Text("Autenticate con Biometría")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
}

extension BiometricAuthView {
    
    class Models: ObservableObject {
        @Published var errorMessage: String = ""
    }
    
    struct Events {
        var onAuthenticateUserTapped: (() -> Void)?
    }
}

#Preview {
    BiometricAuthView()
}
