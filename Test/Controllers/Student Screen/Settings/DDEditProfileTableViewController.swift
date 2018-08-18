//
//  DDEditProfileTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 17.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

// TODO: Закончить форматирования телефона и улучить UI

import UIKit


class DDEditProfileTableViewController: UITableViewController {
    weak var enterStudent : DDCDStudent!

    struct Indificators {
        static let editProfileCell = "editProfileCell"
    }
    let picker = DDMyImagePickerController()
   
    var chosenImage = UIImage()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chosenImage = UIImage(data: enterStudent.photo! as Data)!
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundForSettingsScreen.jpg"))
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.editProfileCell, for: indexPath) as! DDEditProfileTableViewCell
        
        cell.loginTextField.text = enterStudent.login
        if enterStudent.phone == nil {
            cell.phoneNumberTextField.text = "+"
        }
        cell.phoneNumberTextField.text = enterStudent.phone
        
        if let photo = enterStudent.photo {
            cell.photoImageView.image = UIImage(data: photo as Data)
        } else {
            let image = UIImage(named: "noimage.jpg")
            
            cell.photoImageView.image = image
        }

        return cell
    }
    
    //MARK: Actions
    @IBAction func choisePhotoButtonAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Select photo", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let album = UIAlertAction(title: "Album", style: .default) { [unowned self] (action) in
            let presentVC = self.picker.photoFromAlbum()
            self.present(presentVC, animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { [unowned self] (action) in
            let presentVC = self.picker.photoFromCamera()
            self.present(presentVC, animated: true, completion: nil)
        }
        actionSheet.addAction(album)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)

    }
    
    @IBAction func cancelBarButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBarButtonAction(_ sender: Any) {
         let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        if !emptyLoginTextField() {
             enterStudent.login = cell.loginTextField.text
        }
        if !emptyPhoneNumberTextField() {
             enterStudent.phone = cell.phoneNumberTextField.text
        }
        let imageData : NSData = UIImagePNGRepresentation(chosenImage)! as NSData
        enterStudent.photo = imageData
        DDCoreDataManager.instance.saveContext()
        dismiss(animated: true, completion: nil)
    }
    

}

extension DDEditProfileTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
 
  
        if let originalImage = info[UIImagePickerControllerOriginalImage] {
            chosenImage = originalImage as! UIImage
        } else if let editedImage = info[UIImagePickerControllerEditedImage] {
             chosenImage = editedImage as! UIImage
        }
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        cell.photoImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension DDEditProfileTableViewController : UITextFieldDelegate {
   

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        if textField == cell.phoneNumberTextField {
            if cell.phoneNumberTextField.text == "" {
                cell.phoneNumberTextField.text = "+"
            }
        }
      
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        guard let text = textField.text as NSString? else {
            return true
        }
    
        
        let resultString = text.replacingCharacters(in: range, with: string)
       
        let numberString = resultString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
       
        if textField == cell.phoneNumberTextField {
            cell.phoneNumberTextField.text = formattedNumber(number: numberString)
           
           
        } else {
            return true
        }
        return false
    }
    
   
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = "+XX (XXX) XXX XX XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask.characters {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func emptyLoginTextField() -> Bool {
         let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        if cell.loginTextField == nil {
            return false
        } else {
            return true
        }
    }

    func emptyPhoneNumberTextField() -> Bool {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DDEditProfileTableViewCell
        if cell.phoneNumberTextField.text?.count != 19  {
            return true
        }
        return false
    }
  
    
    
}




