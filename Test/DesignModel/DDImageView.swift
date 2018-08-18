//
//  DDImageView.swift
//  CoreDataTest
//
//  Created by Duba on 18.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
@IBDesignable
class DDImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
