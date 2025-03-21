//
//  QRScannerViewController.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI
import Combine
import UIKit
import Flutter
import FlutterPluginRegistrant

class QRScannerViewController: UIViewController {

    private var viewModel = QRScannerViewModel()
    private var flutterDependencies: FlutterDependencies
    private var hostingController: UIHostingController<QRScannerView>?
    private var cancellables = Set<AnyCancellable>()

    init(flutterDependencies: FlutterDependencies) {
        self.flutterDependencies = flutterDependencies
        super.init(nibName: nil, bundle: nil)
        
        setupScannerView()
        observeScannedCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}


// MARK: - Private methods

private extension QRScannerViewController {
    
    func setupScannerView() {
        let qrScannerView = QRScannerView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: qrScannerView)
        self.hostingController = hostingController
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    func observeScannedCode() {
        viewModel.$scannedCode
            .compactMap { $0 }
            .sink { [weak self] scannedCode in
                guard let self = self else { return }
                print(scannedCode)
                openFlutterApp(message: scannedCode)
            }
            .store(in: &cancellables)
    }

    func openFlutterApp(message: String) {
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
            let window = windowScene.windows.first(where: \.isKeyWindow),
            let rootViewController = window.rootViewController
        else { return }

        let flutterViewController = FlutterViewController(
            engine: flutterDependencies.flutterEngine,
            nibName: nil,
            bundle: nil
        )
        
        let channel = FlutterMethodChannel(name: "com.lmarca.channel",
                                           binaryMessenger: flutterViewController.binaryMessenger)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            channel.invokeMethod("sendText", arguments: message)
        }
        
        flutterViewController.modalPresentationStyle = .overCurrentContext
        flutterViewController.isViewOpaque = false

        rootViewController.present(flutterViewController, animated: true)
    }
}

extension QRScannerViewController {
    
    static func build() -> QRScannerViewController {
        QRScannerViewController(flutterDependencies: FlutterDependencies())
    }
}

class QRScannerViewModel: ObservableObject {
    
    @Published var scannedCode: String? = nil
}
