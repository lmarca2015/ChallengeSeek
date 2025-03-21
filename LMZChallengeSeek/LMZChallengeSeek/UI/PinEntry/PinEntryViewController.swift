//
//  PinEntryViewController.swift
//  LMZChallengeSeek
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI

class PinEntryViewController: UIHostingController<PinEntryView> {
    
    init(pinEntryView: PinEntryView) {
        super.init(rootView: pinEntryView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PinEntryViewController {
    
    static func build() -> PinEntryViewController {
        let view = PinEntryView()
        let controller = PinEntryViewController(pinEntryView: view)
        
        return controller
    }
}


// MARK: - Private methods

private extension PinEntryViewController {
    
    func setViewEvents() {
        rootView.events.onQRScannerTapped = { [weak self] in
            self?.routeToQRScanner()
        }
    }
    
    func routeToQRScanner() {
        let controller = QRScannerViewController.build()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
