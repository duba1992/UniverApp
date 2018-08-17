//
//  RoundButton.swift
//  CoreDataTest
//
//  Created by Duba on 27.06.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class DDRoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
