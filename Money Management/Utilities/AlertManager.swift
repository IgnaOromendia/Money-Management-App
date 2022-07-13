//
//  AlertManager.swift
//  Money Management
//
//  Created by Igna on 13/07/2022.
//

import Foundation
import UIKit

class AlertManager {
    
    private var vc: UIViewController
    private let defalutAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    private let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    init(_ viewController: UIViewController = UIViewController()) {
        self.vc = viewController
    }
    
    func setViewController(_ viewController: UIViewController) {
        self.vc = viewController
    }
    
    func share(_ items: [Any]) {
        let shareScreen = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.present(shareScreen, animated: true)
    }
    
    func simpleAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(defalutAction)
        vc.present(alert, animated: true)
    }
    
    func deleteAlert(title: String?, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            completion()
        }))
        vc.present(alert, animated: true)
    }
}
