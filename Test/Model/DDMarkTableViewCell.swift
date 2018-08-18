//
//  DDMarkTableViewCell.swift
//  CoreDataTest
//
//  Created by Duba on 03.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import UIKit

class DDMarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var markLabel : UILabel!
    
    var date : String! {
        didSet {
            dateLabel.text = "Date: " + date
        }
    }
    
    var mark : String! {
        didSet {
            markLabel.text = "Mark: " + mark
        }
    }
}
