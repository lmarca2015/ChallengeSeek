//
//  PinEntryView.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI

struct PinEntryView: View {
    @State private var pin: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    var events = Events()

    var body: some View {
        VStack {
            Text("Ingrese su PIN")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            HStack(spacing: 16) {
                ForEach(0..<4, id: \.self) { index in
                    TextField("", text: $pin[index])
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .focused($focusedIndex, equals: index)
                        .onChange(of: pin[index]) { newValue in
                            if newValue.count > 1 {
                                pin[index] = String(newValue.prefix(1))
                            }
                            if !newValue.isEmpty && index < 3 {
                                focusedIndex = index + 1
                            }
                        }
                }
            }

            Button(action: validatePin) {
                Text("Confirmar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
        .onAppear {
            focusedIndex = 0
        }
    }

    func validatePin() {
        let enteredPin = pin.joined()
        events.onQRScannerTapped?()
    }
}

extension PinEntryView {
    
    struct Events {
        var onQRScannerTapped: (() -> Void)?
    }
}

#Preview {
    PinEntryView()
}
