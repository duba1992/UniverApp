//
//  DDDesinableView.swift
//  CoreDataTest
//
//  Created by Duba on 02.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import Foundation
import UIKit
@IBDesignable
class DDDesinableView: UIView {
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
