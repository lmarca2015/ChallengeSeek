//
//  QRScannerScreen.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

struct QRScannerScreen: UIViewControllerRepresentable {
    
    @EnvironmentObject var flutterDependencies: FlutterDependencies

    func makeUIViewController(context: Context) -> QRScannerViewController {
        QRScannerViewController(flutterDependencies: flutterDependencies)
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {}
}

#Preview {
    QRScannerScreen()
}
