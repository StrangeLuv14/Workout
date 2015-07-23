//
//  RecruitViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

func == <T: Equatable> (tuple1:(T, T), tuple2:(T, T)) -> Bool {
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}

class RecruitViewController: UITableViewController {
    
    enum EdittingDate {
        case StartDate
        case EndDate
        case NoDate
    }
    
    var recruitment = Recruitment()
    
    var dateToEdit = EdittingDate.NoDate
    
    var datePickerVisible = false

    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - RecruitViewController methods
    
    func showDatePicker() {
        
        datePickerVisible = true
        
        let indexPathDateRow = NSIndexPath(forRow: 3, inSection: 0)
        let indexPathDatePicker = NSIndexPath(forRow: 4, inSection: 0)
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: .None)
        tableView.endUpdates()
        
        updateDatePicker()
        
    }
    
    func updateDatePicker() {
        let indexPathDatePicker = NSIndexPath(forRow: 4, inSection: 0)
        if let pickerCell = tableView.cellForRowAtIndexPath(indexPathDatePicker) {
            let datePicker = pickerCell.viewWithTag(100) as! UIDatePicker
            datePicker.minimumDate = NSDate()
            let startDate = recruitment.startDate
            let endDate = recruitment.endDate
            switch dateToEdit {
            case .StartDate:
                datePicker.setDate(startDate, animated: true)
            case .EndDate:
                datePicker.setDate(endDate, animated: true)
            default:
                println("Never goes here!")
            }
        }
    }

    func hideDatePicker() {
        if datePickerVisible {
            datePickerVisible = false
            
            let indexPathDateRow = NSIndexPath(forRow: 3, inSection: 0)
            let indexPathDatePicker = NSIndexPath(forRow: 4, inSection: 0)
            
            tableView.beginUpdates()
            tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: .None)
            tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        switch dateToEdit {
            case .StartDate:
                recruitment.startDate = datePicker.date
                if recruitment.startDate.compare(recruitment.endDate) == NSComparisonResult.OrderedDescending {
                    recruitment.endDate = recruitment.startDate
            }
            case .EndDate:
                recruitment.endDate = datePicker.date
                if recruitment.endDate.compare(recruitment.startDate) == NSComparisonResult.OrderedAscending {
                    recruitment.startDate = recruitment.endDate
                }
            
            default:break
        }
        updateDateLabel()
    }
    
    private func updateDateLabel() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        
        let startDate = recruitment.startDate
        let endDate = recruitment.endDate
        
        startDateLabel.text = formatter.stringFromDate(startDate)
        endDateLabel.text = formatter.stringFromDate(endDate)
 
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if  section == 0 && datePickerVisible {
            return 5
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("tableView(_:, cellForRowAtIndexPath: \(indexPath.section),\(indexPath.row))")
        if (indexPath.section, indexPath.row) == (0, 4) {
            println("insert datePicker")
            var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("DatePickerCell") as? UITableViewCell
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "DatePickerCell")
                cell.selectionStyle = .None
                
                let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 320, height: 216))
                datePicker.tag = 100
                cell.contentView.addSubview(datePicker)
                
                datePicker.addTarget(self, action: Selector("dateChanged:"), forControlEvents: .ValueChanged)
                
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 4):
            return 217
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if (indexPath.section, indexPath.row) == (0, 4) {
            indexPath = NSIndexPath(forRow:0, inSection: indexPath.section)
        }
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        let currentDatePickerState = dateToEdit
        switch (indexPath.section, indexPath.row) {
        case (0, 2):
            println("Editting StartDate")
            dateToEdit = .StartDate
            switch currentDatePickerState {
            case .NoDate:
                showDatePicker()
                
            case .StartDate:
                if datePickerVisible {
                    hideDatePicker()
                } else {
                    showDatePicker()
                }
                
            case .EndDate:
                if datePickerVisible {
                    updateDatePicker()
                } else {
                    showDatePicker()
                }
                
            default:break
            }
            
            endDateLabel.textColor = UIColor.lightGrayColor()
            startDateLabel.textColor = startDateLabel.tintColor
        case (0, 3):
            println("Editting EndDate")
            dateToEdit = .EndDate
            switch currentDatePickerState {
                
            case .NoDate:
                showDatePicker()
                
            case .StartDate:
                if datePickerVisible {
                    updateDatePicker()
                } else {
                    showDatePicker()
                }
                
            case .EndDate:
                if datePickerVisible {
                    hideDatePicker()
                } else {
                    showDatePicker()
                }
                
            default:break
            }
            
            startDateLabel.textColor = UIColor.lightGrayColor()
            endDateLabel.textColor = startDateLabel.tintColor
        default:break
        }

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
