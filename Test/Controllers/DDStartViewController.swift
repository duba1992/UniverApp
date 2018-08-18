//
//  StartViewController.swift
//  CoreDataTest
//
//  Created by Duba on 27.05.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase


class DDStartViewController: UIViewController{
    
    //DDInstagramLoginViewController
    @IBOutlet var socialButtons: [DDRoundButton]!
    
    @IBOutlet var enterTextFields: [DDTextField]!
    
    
    var enterStudent : DDCDStudent!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
   
    var initCoreData : DDInitDataForCoreData!

    var facebookLogin : DDFacebookLogin!
   
    struct Indificators {
        static let segueToInstagram = "DDInstagramLoginViewController"
        static let segueEnter = "EnterSuccess"
    }
    deinit {
        print("Goodbye start view\n\n\n\n\n\n\n\n\n\n")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in enterTextFields {
            i.delegate = self
        }
      
        // First init data if needed
        let students = DDCoreDataFetch.requestAllStudents()
        
        if students == nil {
            DispatchQueue.global(qos: .userInteractive).async {
                self.initCoreData = DDInitDataForCoreData()
                self.initCoreData.saveNewGroupsWithSubjects()
                self.initCoreData.saveNewRandomStudents()
                self.initCoreData.saveMyStudent()
            }

        }

        
        // Social buttons animate
        for button in socialButtons {
            button.alpha = 0.001
        }
    
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: { [unowned self] in
                self.bgImage.alpha = 1
            }) { (true) in
                self.showFacebookButton()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if enterStudent != nil {
            
            performSegue(withIdentifier: Indificators.segueEnter, sender: self)
        }
    }
      
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    // MARK: - Animate Functions
    func showFacebookButton() {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.socialButtons[0].alpha = 1
        }) { (true) in
            self.showTwitterButton()
        }
    }
    func showTwitterButton()  {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.socialButtons[1].alpha = 1
        }) { (true) in
            self.showInstagramButton()
        }
    }
    func showInstagramButton() {
      
        
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.socialButtons[2].alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.enterButton.alpha = 1
            })
            
        }
       
    }
    
    
    
    // MARK: - Actions

    @IBAction func twitterButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Try another", message: "Sorry, this version can not be signed in via Twitter", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookButtonAction(_ sender: Any) {
       
            let facebookLogin = DDFacebookLogin()
     
            facebookLogin.FacebookEnterAndGet { [unowned self] (ddUser) in
                if let ddUser = ddUser {
               
                    self.enterStudent = DDCoreDataFetch.enterStudentWith(facebookEmail: ddUser.facebookEmail!)
                    if self.enterStudent != nil {
                           self.performSegue(withIdentifier: Indificators.segueEnter, sender: self)
                    } else {
                        //TODO: Save in DATABASE
                    }
                }
            }
        
    }
    
    func emptyTextFields() -> Bool {
        
        for i in 0..<enterTextFields.count {
            if (enterTextFields[i].text?.isEmpty)! {
                alertForLoginPassword(i)
                return true
            }
        }
        return false
        
    }
    @IBAction func enterButtonAction(_ sender: Any) {
        // Check TextFields is Empty
        if emptyTextFields() {
            return
        }
        
        
        let student = DDCoreDataFetch.enterStudentWith(login: enterTextFields[0].text!, password: enterTextFields[1].text!)
        
        
        guard student != nil else {
        //Wrong login or password
            alertForWrongLoginOrPassword()
            return
        }
   
        //Correct login and password
        enterStudent = student
        performSegue(withIdentifier: Indificators.segueEnter, sender: self)
        
    }
    
        
        //MARK:- Alerts

        func alertForLoginPassword(_ index : Int) {
        var message : String!
        switch index {
        case 0:
            message = "Please enter your login"
            break
        case 1:
            message = "Please enter your password"
            break
        default:
            message = "Error Empty"
        }
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func alertForWrongLoginOrPassword() {
        
        let alert = UIAlertController(title: "Alert", message: "Wrong Login or Password", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    // MARK: - Navigation
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Indificators.segueToInstagram {
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDInstagramLoginViewController {
                      nextVC.delegate = self
                }
            }
            
        } else if segue.identifier == Indificators.segueEnter  {
            if let toolBar = segue.destination as? DDTabBarController {
                toolBar.enterStudent = enterStudent
   
            }
        }
        socialButtons = nil
        enterTextFields = nil
    }

}


//MARK:- DDInstagramLoginDelegate (Get Instagram User)
extension DDStartViewController : DDInstagramLoginDelegate {
    func getInstagramAccessToken(_ accessToken : String) {
        
        DDAlamofireRequest.requestInstagramUser(accessToken,  completion: { [unowned self] (user) in
            guard let instagramID = user  else {
                return
            }
            self.enterStudent  = DDCoreDataFetch.enterStudentWith(instagramID: instagramID)
            print("Enter Student: " + (self.enterStudent?.firstName)! + " " + (self.enterStudent?.lastName)! )
        })
      
        
    }
}

//MARK:- TextFieldDelegate
extension DDStartViewController : UITextFieldDelegate {
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = getActiveTextField(textField as! DDTextField)
            else {
                return false
        }
        if index == enterTextFields.count - 1 {
            
           
            resignFirstResponder()
            return true
        }
        return enterTextFields[index + 1].becomeFirstResponder()
    }
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        guard let index = getActiveTextField(textField as! DDTextField)
            else {
                return false
        }
        for i in (0..<index).reversed() {
            if enterTextFields[i].text == ""{
                enterTextFields[i].shake()
                enterTextFields[i].becomeFirstResponder()
                return false;
            }
        }
        
        return true;
    }
    
    func getActiveTextField(_ textField: DDTextField  ) -> Int?{
        guard let index = enterTextFields.index(of: textField ) else {
            return nil
        }
        return index
    
    
    }
}

