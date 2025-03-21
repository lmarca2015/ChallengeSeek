//
//  BiometricAuthViewController.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI
import LocalAuthentication

class BiometricAuthViewController: UIHostingController<BiometricAuthView> {
    
    @Published private var isAuthenticated = false
    
    init(biometricAuthView: BiometricAuthView) {
        super.init(rootView: biometricAuthView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BiometricAuthViewController {
    
    static func build() -> BiometricAuthViewController {
        let view = BiometricAuthView()
        let controller = BiometricAuthViewController(biometricAuthView: view)
        
        return controller
    }
}


// MARK: - Private methods

private extension BiometricAuthViewController {
    
    func setViewEvents() {
        rootView.events.onAuthenticateUserTapped = { [weak self] in
            self?.authenticateUser()
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Autenticación requerida") { success, authenticationError in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if success {
                        routeToQRScanner()
                    } else {
                        routeToEntryPin()
                    }
                }
            }
        } else {
            self.rootView.models.errorMessage = "Biometría no disponible en este dispositivo"
        }
    }
    
    func routeToEntryPin() {
        let controller = PinEntryViewController.build()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func routeToQRScanner() {
        let controller = QRScannerViewController.build()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
