//
//  LMZChallengeSeekApp.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 20/03/25.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant
import SeekUI

class FlutterDependencies: ObservableObject {
    let flutterEngine = FlutterEngine(name: "flutter_module_engine")
    
    init() {
        flutterEngine.run()
        
        GeneratedPluginRegistrant.register(with: flutterEngine)
    }
}

@main
struct LMZChallengeSeekApp: App {
    
    @StateObject var flutterDependencies = FlutterDependencies()
    
    let root = NavigationController(rootController: BiometricAuthViewController.build())
    
    var body: some Scene {
        WindowGroup {
            root.ignoresSafeArea().environmentObject(flutterDependencies)
        }
    }
}
