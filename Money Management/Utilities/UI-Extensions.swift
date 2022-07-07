//
//  UI-Extensions.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import Foundation
import UIKit

extension UIView {
    /// Set a default shadow
    var shadow: Bool {
        get {
            if self.layer.shadowRadius > 0 {
                return true
            } else {
                return false
            }
        } set {
            if newValue {
                self.layer.shadowOpacity = 0.2
                self.layer.shadowOffset = .init(width: 1, height: 1)
                self.layer.shadowRadius = 3
                self.layer.shadowColor = UIColor.label.cgColor
            } else {
                self.layer.shadowOpacity = 0
                self.layer.shadowOffset = .init(width: 0, height: 0)
                self.layer.shadowRadius = 0
            }
        }
    }
    
    /// Set corner radius
    func cornerRadius(of numero:CGFloat) {
        self.layer.cornerRadius = numero
    }
    
    /// Apply a blur effect to a view
    func applyBlurEffect(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(blurEffectView)
        self.clipsToBounds = true
    }
    
}

extension UIColor {
    /// Set a RGB color
    static func rgbColor(r:Int, g:Int, b:Int) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    /// Generates a random color
    static func randomColor() -> UIColor {
        let randomRed = Int.random(in: 0...255)
        let randomGreen = Int.random(in: 0...255)
        let randomBlue = Int.random(in: 0...255)
        return rgbColor(r: randomRed, g: randomGreen, b: randomBlue)
    }
    
    func ligthUp(delta: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(red: addDelta(delta, to: red), green: addDelta(delta, to: green), blue: addDelta(delta, to: blue), alpha: alpha)
    }
    
    private func addDelta(_ value: CGFloat, to componenet: CGFloat) -> CGFloat {
        return max(0, min(1, componenet + value))
    }
    
    
}
