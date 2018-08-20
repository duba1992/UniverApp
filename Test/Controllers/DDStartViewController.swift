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
    @IBOutlet var shadowView: UIView!
    
    var initCoreData : DDInitDataForCoreData!

    var facebookLogin : DDFacebookLogin!
   
    let activityView = UIActivityIndicatorView()
    
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

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
        }) {[unowned self]  (true) in
            self.showInstagramButton()
        }
    }
    func showInstagramButton() {
      
        
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.socialButtons[2].alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {[unowned self] in
                self.enterButton.alpha = 1
            })
            
        }
       
    }
    func showShadowViewWithActivityIndicator() {
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.activityIndicatorViewStyle = .whiteLarge
        activityView.startAnimating()
        shadowView.addSubview(activityView)
        view.addSubview(shadowView)
        UIView.animate(withDuration: 0.2) {[unowned self] in
            self.shadowView.alpha = 0.8
        }
        
    }
    
    func hideShadowViewWithActivityIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.2) {[unowned self] in
            self.activityView.stopAnimating()
            self.shadowView.alpha = 0.0
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
            showShadowViewWithActivityIndicator()
            facebookLogin.FacebookEnterAndGet(completion: { [unowned self] (ddUser) in
                
                if let ddUser = ddUser {
                  
                    self.enterStudent = DDCoreDataFetch.enterStudentWith(facebookEmail:
                        ddUser.facebookEmail!)
                if self.enterStudent != nil {
                    self.performSegue(withIdentifier: Indificators.segueEnter, sender: self)
                } else {
                    //TODO: Save in DATABASE
                }
            }
        }) { [unowned self] (error) in
            if error != nil {
                self.hideShadowViewWithActivityIndicator()
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
        
        showShadowViewWithActivityIndicator()
        let student = DDCoreDataFetch.enterStudentWith(login: enterTextFields[0].text!, password: enterTextFields[1].text!)
        
        
        guard student != nil else {
        //Wrong login or password
            alertForWrongLoginOrPassword()
            hideShadowViewWithActivityIndicator()
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
            showShadowViewWithActivityIndicator()
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
    func getInstagramAccessToken(_ accessToken : String, error : String?) {
        if error != nil {
            hideShadowViewWithActivityIndicator()
            return
        }
        
        DDAlamofireRequest.requestInstagramUser(accessToken,  completion: { [unowned self] (instagramID, error) in
            if error != nil {
                self.hideShadowViewWithActivityIndicator()
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

