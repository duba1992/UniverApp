//
//  DDTextField.swift
//  CoreDataTest
//
//  Created by Duba on 29.06.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
@IBDesignable
class DDTextField: UITextField {

    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftImage : UIImage?{
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    func  updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = 20 + leftPadding
//            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
//                width = width + 5
//            }
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
            
        } else {
            leftViewMode = .never
        }
        attributedPlaceholder = NSAttributedString(attributedString: NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor : tintColor]))
    }
    
    
    
    

}
