//
//  DDWeakTimeTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 25.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData
class DDWeakTimeTableViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var enterDate : Date!
    var choisenCell : DDCalendarCell!
    var journals : [DDJournal]!
    weak var enterStudent : DDCDStudent!
    struct Indificators {
        static let calendarCell = "calendarCell"
        static let timeTableSubjectCell = "timeTableSubjectCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        
        
        // Do any additional setup after loading the view.w
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendarView.scrollToDate(enterDate)
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
       
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - JTAppleCalendar function
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
    }
    
    func hideSelectedView(view : JTAppleCell?, cellState : CellState) {
        let cell = view as! DDCalendarCell
        
        if cell.dateLabel.text == "24" {
            
        }
        if isCurrentDay(cellState: cellState) {
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.red
        } else if isChoisenDay(cellState: cellState) {
           
           
            cell.isSelected = true
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.orange
            cell.isSelected = false
            choisenCell = cell
            enterDate = Date(timeIntervalSince1970: TimeInterval())
          
        }  else if cell.isSelected  {
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.orange
            guard choisenCell != nil else { return }
            choisenCell.isSelected = false
            choisenCell.selectedView.isHidden = true
            choisenCell = nil
          
        } else {
            cell.selectedView.isHidden = true
            cell.selectedView.backgroundColor = UIColor.orange
        }
      
    }
    
    func textDateColor(view : JTAppleCell?, cellState : CellState) {
        
        guard  let validCell = view  else { return }
        let cell = validCell as! DDCalendarCell
        
        if cell.isSelected {
            cell.dateLabel.textColor = .white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                cell.dateLabel.textColor = .white
            } else {
                cell.dateLabel.textColor = .gray
            }
        }
    }
    func isChoisenDay(cellState : CellState) -> Bool {

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        guard enterDate != nil else { return false }
        let currentDateString = dateFormatter.string(from: enterDate)
        let cellStateDateString = dateFormatter.string(from: cellState.date)
        if currentDateString == cellStateDateString {
            enterDate = nil
            
           
            return true
            
        } else {
            return false
        }
    }
    func isCurrentDay(cellState : CellState) -> Bool {
        let currentDay = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        
        let currentDateString = dateFormatter.string(from: currentDay)
        let cellStateDateString = dateFormatter.string(from: cellState.date)
        if currentDateString == cellStateDateString {
            return true
        } else {
            return false
        }
    }
    
    

}

extension DDWeakTimeTableViewController : JTAppleCalendarViewDataSource {
    //MARK: - JTAppleCalendarViewDataSource
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "01-01-2018 00:00")
        let endDate = formatter.date(from: "31-12-2018 00:00")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, numberOfRows: 1, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .off, firstDayOfWeek: .monday, hasStrictBoundaries: true)
        
        return parameters
    }
    
}

extension DDWeakTimeTableViewController : JTAppleCalendarViewDelegate {
    //MARK: - JTAppleCalendarViewDelegate
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM"
        dateLabel.text = formatter.string(from: date)
        
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let validCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: Indificators.calendarCell, for: indexPath) as! DDCalendarCell
        validCell.dateLabel.text = cellState.text
        hideSelectedView(view: validCell, cellState: cellState)
        textDateColor(view: validCell, cellState: cellState)
       
        
        
        return validCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if cellState.dateBelongsTo != .thisMonth {
            return
        }
        guard  var validCell = cell  else { return }
        validCell = validCell as! DDCalendarCell
        
        hideSelectedView(view: validCell, cellState: cellState)
        let myDate = date.addingTimeInterval(TimeInterval(3600 * 3.0))
   
      
  
        journals = DDCoreDataFetch.requestJournal(forGroupe: enterStudent.groupe!, andDate: myDate)
        let journalses = DDCoreDataFetch.requestAllJournals()

        tableView.reloadData()
        
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard  var validCell = cell  else { return }
        validCell = validCell as! DDCalendarCell
        
        hideSelectedView(view: validCell, cellState: cellState)
    }
}

extension DDWeakTimeTableViewController : UITableViewDelegate, UITableViewDataSource {
    // MARK: - Fetch Result Controller init

    
    
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Indificators.timeTableSubjectCell, for: indexPath) as! DDTimeTableSubjectTableViewCell
        
        let object = journals[indexPath.row]
        
        let housing = DDCoreDataFetch.requestHousing(byLatitude: object.latitude, andLongitude: object.longitude)
        
        cell.housingNameLabel.text = housing?.name ?? " "
        let date = object.date?.description.split(separator: " ")
        cell.timeLabel.text = String(date?[1] ?? " ")
        cell.sublectLabel.text = object.subject
        
        
        return cell
    }
    //MARK:- UITableViewDelegate
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
}


