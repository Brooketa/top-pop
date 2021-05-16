//
//  UIImageViewExtensions.swift
//  TopPop
//
//  Created by Brooketa on 16.05.2021..
//

import UIKit

extension UIImageView {
    func roundCorners(withCornerRadius cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}

