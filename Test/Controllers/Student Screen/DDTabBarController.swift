//
//  DDTabBarController.swift
//  CoreDataTest
//
//  Created by Duba on 07.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDTabBarController: UITabBarController {


    weak var enterStudent : DDCDStudent!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // init ViewControllers 
        let navController1 = self.viewControllers![0] as! UINavigationController
        let vc1 = navController1.topViewController as! DDSubjectsTableViewController
        vc1.enterStudent = enterStudent
        vc1.initializeFetchedResultsController()    
        
        let navController2 = self.viewControllers![1] as! UINavigationController
        let vc2 = navController2.topViewController as! DDStudentsCollectionViewController
        vc2.enterStudent = enterStudent
        
        
        let navController3 = self.viewControllers![2] as! UINavigationController
        let vc3 = navController3.topViewController as! DDSettingsTableViewController
        vc3.enterStudent = enterStudent
        
        let navController4 = self.viewControllers![3] as! UINavigationController
        let vc4 = navController4.topViewController as! DDTimeTableViewController
        vc4.enterStudent = enterStudent
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("Goodbye Tab Bar Controller \n\n\n")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

