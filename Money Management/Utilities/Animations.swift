//
//  Animations.swift
//  Money Management
//
//  Created by Igna on 09/07/2022.
//

import Foundation
import UIKit

final class Animator {
    
    /// Make the current alpha equal to value in a smooth way
    func animateAlpha(of view: UIView, to value: Double) {
        UIView.animate(withDuration: 0.5) {
            view.alpha = value
        }
    }
}
