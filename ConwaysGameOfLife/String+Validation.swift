//
//  String+Validation.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 26/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func removeWhiteSpaces() -> String {
        var s = self
        s = s.trimmingCharacters(in: CharacterSet.whitespaces)
        s = s.replacingOccurrences(of: " ", with: "")
        return s
    }
    
    func onlyNumber() -> Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        let s  = self.removeWhiteSpaces()
        guard s != "", rangeOfCharacter(from: notDigits) == nil else {
            return false
        }
        return true
    }
}
