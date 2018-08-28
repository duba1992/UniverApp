
//
//  DDTimeTableViewController.swift
//  CoreDataTest
//
//  Created by Duba on 24.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import JTAppleCalendar
class DDTimeTableViewController: UIViewController {

    var enterStudent : DDCDStudent!
    var choisenDate : Date!
  
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var backCalendarButton: UIButton!
    
    @IBOutlet weak var forwardCalendarButton: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    

    struct Indificators {
        static let calendarCell = "calendarCell"
        static let segueToWeakTimeTable = "segueToWeakTimeTable"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        calendarView.scrollToDate(Date())
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendarView.reloadData()
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
        
        
        
        if isCurrentDay(cellState: cellState) {
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.red
        } else if cell.isSelected {
            cell.selectedView.isHidden = false
        }
        else {
            cell.selectedView.isHidden = true
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
    //MARK: - Actions
    
    @IBAction func backCalendarButtonAction(_ sender: Any) {
        
        calendarView.scrollToSegment(.previous)
    }

    @IBAction func forwardCalendarButtonAction(_ sender: Any) {
        calendarView.scrollToSegment(.next)
    }
    
    
     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Indificators.segueToWeakTimeTable {
            if let nextVC = segue.destination as? DDWeakTimeTableViewController {
                if choisenDate != nil {
                     nextVC.enterDate = choisenDate
                    nextVC.enterStudent = enterStudent
                    if enterStudent.groupe != nil {
                        nextVC.journals = DDCoreDataFetch.requestJournal(forGroupe: enterStudent.groupe!, andDate: choisenDate)
                    }
                    
                }

            }
        }
        
    }
 
    


}



extension DDTimeTableViewController : JTAppleCalendarViewDataSource {
    //MARK: - JTAppleCalendarViewDataSource
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "01-01-2018 00:00")
        let endDate = formatter.date(from: "31-12-2018 00:00")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, numberOfRows: 5, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .off, firstDayOfWeek: .monday, hasStrictBoundaries: true)
        
        return parameters
    }

}

extension DDTimeTableViewController : JTAppleCalendarViewDelegate {
    //MARK: - JTAppleCalendarViewDelegate
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
   
        
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
        
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let validCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: Indificators.calendarCell, for: indexPath) as! DDCalendarCell
        
        hideSelectedView(view: validCell, cellState: cellState)
        textDateColor(view: validCell, cellState: cellState)
        validCell.dateLabel.text = cellState.text

        
        return validCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if cellState.dateBelongsTo != .thisMonth {
          return
        }
        guard  var validCell = cell  else { return }
        validCell = validCell as! DDCalendarCell
        choisenDate = cellState.date
        hideSelectedView(view: validCell, cellState: cellState)
         self.performSegue(withIdentifier: Indificators.segueToWeakTimeTable, sender: self)
      
       
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard  var validCell = cell  else { return }
        validCell = validCell as! DDCalendarCell
       
        hideSelectedView(view: validCell, cellState: cellState)
    }
}

