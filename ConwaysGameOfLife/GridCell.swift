//
//  GridCell.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 27/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import UIKit

class GridCell: UIView {

    var selected: Bool? {
        didSet {
            if selected! {
                UIView.animate(withDuration: 0.1, animations: {
                    self.backgroundColor = UIColor.black
                })
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.backgroundColor = UIColor.white
                })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(length: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        self.selected = false
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        let innerButton = UIButton(type: .custom)
        innerButton.frame = self.frame
        innerButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
        self.addSubview(innerButton)
        
    }
    
    func pressed(sender: AnyObject) {
        self.selected = !self.selected!
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
