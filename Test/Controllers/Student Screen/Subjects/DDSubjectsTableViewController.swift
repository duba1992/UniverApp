//
//  DDSubjectsTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 08.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import CoreData
class DDSubjectsTableViewController: UITableViewController {
  
    var subjectMarks : [DDMark]!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    public var enterStudent : DDCDStudent!
    
   
    
    @IBOutlet weak var hImageView: UIImageView!
    struct Indificators {
        static let subjectCell = "SubjectCell"
        static let segueToMarks = "DDMarkTableViewController"
        
    }
    
    var headerView : UIView!
    var newHeaderLayer : CAShapeLayer!
    
    let headerViewHeight : CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHeaderView()
        self.tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        // Set navigationController for HeaderImageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.black
       
    }
    
    
    //MARK:- funcutions for animate header Image View
    func updateHeaderView() {
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        if let photo = enterStudent.photo {
            
            
         
            hImageView.image = UIImage(data: photo as Data)
            
            self.headerView.addSubview(hImageView)
            
        }
        
        tableView.addSubview(headerView)
        
        newHeaderLayer = CAShapeLayer()
        newHeaderLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = newHeaderLayer
        
        let newHeight = headerViewHeight
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        self.setupNewHeaderView()
        
    }
    func setupNewHeaderView() {
        let newHeight  = headerViewHeight
        
        var headerFrame = CGRect(x: 0, y: -newHeight, width: self.tableView.bounds.width, height: newHeight)
        
        
        if tableView.contentOffset.y < CGFloat(newHeight) {
            headerFrame.origin.y = tableView.contentOffset.y
            headerFrame.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: headerFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: headerFrame.width, y: headerFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: headerFrame.height))
        newHeaderLayer.path = cutDirection.cgPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.setupNewHeaderView()
        
        var offset = scrollView.contentOffset.y / 150
        if offset > -0.5
        {
            UIView.animate(withDuration: 0.2, animations: {
                offset = 1
                // Show Navigation Controller
                let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                let navigationColor = UIColor.init(hue: 0, saturation: offset, brightness: 1, alpha: 1)
                
                self.navigationController?.navigationBar.tintColor = navigationColor
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: navigationColor]
                self.navigationController?.navigationBar.barStyle = .default
          
                self.navigationItem.title = self.enterStudent.firstName! + " " + self.enterStudent.lastName!
               
                
            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                //Remobe navigationController to background
                
                let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
                      self.navigationItem.title = ""
                self.navigationItem.titleView = nil
              
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Fetch Result Controller init
   public func initializeFetchedResultsController() {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:  DDSubject.typeName)
        let firstNameSort = NSSortDescriptor(key: "name", ascending: true)
        let fetchPredicate = NSPredicate(format: "ANY student = %@", enterStudent)
        
        let moc = DDCoreDataManager.instance.managedObjectContext
        
        request.sortDescriptors = [firstNameSort]
        request.fetchBatchSize = 20
        request.predicate = fetchPredicate
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    //MARK:- UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.subjectCell, for: indexPath)
     
        let object = fetchedResultsController.object(at: indexPath) as? DDSubject
      
        cell.textLabel?.text = object?.name
        cell.textLabel?.numberOfLines = 0
        
        
        return cell
    }
    //MARK:- UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subjectChoise = fetchedResultsController.object(at: indexPath) as! DDSubject
        
        self.subjectMarks = DDCoreDataFetch.requestSubjectMark(forSubject: subjectChoise, forStudent: enterStudent)
        
        
        self.performSegue(withIdentifier: Indificators.segueToMarks, sender: self)
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    //MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Indificators.segueToMarks {
            if let nextVC = segue.destination as? DDMarkTableViewController {
                nextVC.marks = subjectMarks
            }
        }
        
    }
    

}
