//
//  DDChangePasswordTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 18.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit


class DDChangePasswordViewController: UIViewController {
     weak var enterStudent : DDCDStudent!
 
    @IBOutlet var passwordTextFields: [DDTextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //MARK: - Actions
    @IBAction func cancelBarButtomAction(_ sender: Any) {
        passwordTextFields = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBarButtonAction(_ sender: Any) {
       
        for textField in passwordTextFields {
            if textField.text == ""{
                textField.shake()
                return
            }
        }
       
        if passwordTextFields[0].text != enterStudent.password {
            showAlert(withText: "Wrong old password")
            return
        } else if passwordTextFields[1].text != passwordTextFields[2].text {
            showAlert(withText: "Passwords do not match")
            return
        }
        enterStudent.password = passwordTextFields[1].text
        passwordTextFields = nil
        DDCoreDataManager.instance.saveContext()
        dismiss(animated: true, completion: nil)
        
        
    }
    func showAlert(withText text : String) {
        let alert = UIAlertController(title: "Wrong", message: text, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DDChangePasswordViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = getActiveTextField(textField as! DDTextField)
            else {
                return false
        }
        if index == passwordTextFields.count - 1 {
            
            
            doneBarButtonAction(self)
            return true
        }
        return passwordTextFields[index + 1].becomeFirstResponder()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        guard let index = getActiveTextField(textField)
            else {
                return false
        }
        for i in (0..<index).reversed() {
            if passwordTextFields[i].text == ""{
                passwordTextFields[i].shake()
                passwordTextFields[i].becomeFirstResponder()
                return false;
            }
        }
        
        return true;
    }
    
    func getActiveTextField(_ textField: UITextField) -> Int?{
        guard let index = passwordTextFields.index(of: textField as! DDTextField ) else {
            return nil
        }
        return index
        
        
    }
}

