//
//  DDMyImagePickerController.swift
//  CoreDataTest
//
//  Created by Duba on 17.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDMyImagePickerController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.allowsEditing = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func photoFromAlbum() -> UIViewController {
        self.sourceType = .photoLibrary
        self.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.modalPresentationStyle = .popover
        return self
     
    }
    
    func photoFromCamera() -> UIViewController {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        self.allowsEditing = false
        self.sourceType = UIImagePickerControllerSourceType.camera
        self.cameraCaptureMode = .photo
        self.modalPresentationStyle = .fullScreen
            return self
    
        } else {
            let alert = noCamera()
            return alert
        }
    }
    func noCamera() -> UIViewController {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
       return alertVC
    }

    

}
