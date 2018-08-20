//
//  DDSettingsTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 17.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDSettingsTableViewController: UITableViewController {

    public var enterStudent : DDCDStudent!
   
    struct Indificators {
        static let loginPhoneCell = "loginPhoneCell"
        static let changePasswordCell = "changePasswordCell"
        static let signInCell = "signInCell"
         static let emptyCell = "emptyCell"
        static let segueToEditProfile = "segueToEditProfile"
        static let segueToChangePassword = "segueToChangePassword"
        static let segueToInstagram = "segueToInstagram"
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundForSettingsScreen.jpg"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        switch indexPath.row {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.loginPhoneCell, for: indexPath) as! DDLoginPhoneTableViewCell
            cell.loginLable.text = enterStudent.login
            cell.phoneNumberLabel.text = enterStudent.phone == "" ? "No Phone Number" : enterStudent.phone
            
            if let photo = enterStudent.photo {
                cell.photoImageView.image = UIImage(data: photo as Data)
            } else {
                let image = UIImage(named: "noimage.jpg")
                
                cell.photoImageView.image = image
            }
            
            return cell
            
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.changePasswordCell, for: indexPath)
   
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.signInCell, for: indexPath)
          
              return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.emptyCell, for: indexPath)
            return cell  
        }

    }
   

     func spaceCell(cell: inout UITableViewCell) {
        
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 70))
  
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0

        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    
    //MARK: - Actions
    
    @IBAction func facebookButtonAction(_ sender: Any) {
        let facebookLogin = DDFacebookLogin()
        
        facebookLogin.getFacebookEmail { [unowned self](email) in
            self.enterStudent.facebookEmail = email
        }
    }
    
    @IBAction func twitterButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Try another", message: "Sorry, this version can not be signed in via Twitter", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func instagramButtonAction(_ sender: Any) {
       
     
        
     
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Indificators.segueToEditProfile {
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDEditProfileTableViewController {
                    nextVC.enterStudent = enterStudent
                }
            }
        }
        else if segue.identifier == Indificators.segueToChangePassword {
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDChangePasswordViewController {
                    nextVC.enterStudent = enterStudent
                }
            }
        }  else if segue.identifier == Indificators.segueToInstagram {
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDInstagramLoginViewController {
                    nextVC.delegate = self
                }
            }
            
        }
       
    }
    

}

extension DDSettingsTableViewController : DDInstagramLoginDelegate {
    func getInstagramAccessToken(_ accessToken: String, error: String?) {
        if error != nil {
            return
        }
         enterStudent.instagramID = accessToken
    }

}

