//
//  DDMarkTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 03.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDMarkTableViewController: UITableViewController {
    var marks : [DDMark]!
    
    struct Indificators {
        static let markCell = "MarkCell"
        
    }
    
    override func viewDidLoad() {
        
        // sorted marks by date
        let object = marks.sorted(by: {
            $0.date?.compare($1.date! as Date) == .orderedDescending
        })
        marks = object
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barStyle = .default
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = marks.count
        if count == 0 {
            navigationItem.title = "No marks"
        } else {
            navigationItem.title = marks[0].subject?.name
        }
        return count > 0 ? count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.markCell, for: indexPath) as! DDMarkTableViewCell
        let object = marks[indexPath.row]
        cell.mark = String(object.mark)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: object.date! as Date)
        
        cell.date = String(myString)
        
        
        return cell
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
