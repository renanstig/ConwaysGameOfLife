//
//  UIView + Constraints.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 28/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func centerInSuperview() {
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
    }
    
    func centerHorizontallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 64)
        self.superview?.addConstraint(c)
    }
    
    func centerVerticallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 64)
        self.superview?.addConstraint(c)
    }
    
}
