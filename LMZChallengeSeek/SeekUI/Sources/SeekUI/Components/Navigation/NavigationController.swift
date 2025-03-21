//
//  NavigationController.swift
//  SeekUI
//
//  Created by Luis Marca on 21/03/25.
//

import SwiftUI

@available(iOS 13.0, *)
public struct NavigationController: UIViewControllerRepresentable {
    
    public let rootController: UIViewController
    
    public init(rootController: UIViewController) {
        self.rootController = rootController
    }
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: self.rootController)
    }

    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

@MainActor
public protocol NavigationBarStyle {
    func configure(_ viewController: UIViewController)
}

public struct NavigationBarSimpleShow: NavigationBarStyle {
    
    public init() {}

    public func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
    }
}

public struct NavigationBarFullShow: NavigationBarStyle {
    
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.navigationItem.title = self.title
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
    }
}
