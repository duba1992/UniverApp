//
//  DDStudentsCollectionViewController.swift
//  CoreDataTest
//
//  Created by Duba on 29.06.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

import CoreData

class DDStudentsCollectionViewController: UICollectionViewController {
   
    public weak var enterStudent : DDCDStudent!
    
    @IBOutlet weak var myGroupeCollectionView: UICollectionView!
    
    @IBOutlet weak var shadowView: UIView!
   
    // MARK: - Info View
    @IBOutlet weak var  infoFullNameLabel : UILabel!
    @IBOutlet weak var infoAverageMark : UILabel!
    @IBOutlet weak var infoPhotoImageView : UIImageView!
    @IBOutlet weak var infoView : UIView!
    let searchController = UISearchController(searchResultsController: nil)
    let leftAndRightPadding : CGFloat = 32.0
    let numberOfItemsPerRow : CGFloat = 3.0
    let heightAdjustment : CGFloat = 30.0
   
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    
    struct Indificators {
        static let myGroupeCollectionViewCell = "MyGroupeCollectionViewCell"
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Set Search Controller
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.title = self.enterStudent.groupe?.name
        
        
        // Set layouts
        let widthLayout = (collectionView!.frame.width -  leftAndRightPadding) / numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: widthLayout, height: widthLayout + heightAdjustment)

        
        // Get data from CoreData database
       

        
        initializeFetchedResultsController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return fetchedResultsController.sections?.count ?? 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indificators.myGroupeCollectionViewCell, for: indexPath) as! DDStudendsCollectionViewCell
        let student = fetchedResultsController.object(at: indexPath) as! DDCDStudent
        
        if let photo = student.photo {
             cell.photoImageView.image = UIImage(data: photo as Data)
        } else {
            let image = UIImage(named: "noimage.jpg")
         
            cell.photoImageView.image = image
        }
       
        if let firstName = student.firstName {
            cell.fullNameLabel.text = firstName
        }
       
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let student = fetchedResultsController.object(at: indexPath) as! DDCDStudent
        
        // Set properties for InfoLabels and InfoPhoto
        if let photo = student.photo {
            infoPhotoImageView.image = UIImage(data: (photo as Data))
        } else  {
            let image = UIImage(named: "noimage.jpg")
            infoPhotoImageView.image = image
        }
        if let firstName = student.firstName, let lastName = student.lastName {
            infoFullNameLabel.text = firstName + " " + lastName
        } else {
            infoFullNameLabel.text = "No name"
        }
        
        if let averageMark = DDCoreDataFetch.requestAverageMarkByStudent(student: student) {
            infoAverageMark.text = "Averege mark: \(String(format: "%.2f", averageMark ))"
        } else {
            infoAverageMark.text = "No marks"
            
        }
        
        
        //Working with infoView and shadowView
        infoView.center = view.center
        infoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(shadowView)
        view.addSubview(infoView)
       self.searchController.isActive = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.navigationController?.isNavigationBarHidden = true
            self.searchController.searchBar.alpha = 0
            
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.shadowView.alpha = 0.8
            self.infoView.transform = .identity
        })
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognizer:)))
        
        // Add gesteru recognizer for Subviews
        infoView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    //MARK: - Fetch Result Controller (Get data from CoreData)
    func initializeFetchedResultsController() {
        guard let currentGroupe = enterStudent.groupe?.name else {
            return
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:  DDCDStudent.typeName)
        let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
        let fetchPredicate = NSPredicate(format: "groupe.name contains [cd] %@",currentGroupe)
       
        request.sortDescriptors = [firstNameSort, lastNameSort]
        request.fetchBatchSize = 20
        let moc = DDCoreDataManager.instance.managedObjectContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        //fetchedResultsController.delegate = self
        fetchedResultsController.fetchRequest.predicate = fetchPredicate
        
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    // MARK: UICollectionViewDelegate
    
    
   
    // MARK:- Gesture Functionsa
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
       
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.shadowView.alpha = 0.0
            self.navigationController?.navigationBar.alpha = 1
            self.infoView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
             self.searchController.searchBar.alpha = 1

            
        }) { (succesful) in
            self.infoView.removeFromSuperview()
            self.shadowView.removeFromSuperview()
            self.navigationController?.isNavigationBarHidden = false
            self.searchController.hidesNavigationBarDuringPresentation = true
 
        }
    }
    

   

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}




//MARK:- UISearchResultsUpdating
extension DDStudentsCollectionViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let text =  searchController.searchBar.text else {
            return
        }
        guard let groupe = enterStudent.groupe?.name else {
            return
        }
        let fetchPredicate : NSPredicate!
  
        if text == "" {
            fetchPredicate = NSPredicate(format: "groupe.name contains [cd] %@",(enterStudent.groupe?.name)!)
        } else {
             fetchPredicate = NSPredicate(format: "(groupe.name contains [cd] %@) AND (firstName contains [cd] %@ OR lastName contains [cd] %@)", groupe, text, text)
        }
        
        fetchedResultsController.fetchRequest.predicate = fetchPredicate
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        myGroupeCollectionView.reloadData()
    }
   
}


