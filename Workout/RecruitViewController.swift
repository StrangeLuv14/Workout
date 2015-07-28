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

protocol RecruitViewControllerDelegate: class {
    func recruitViewController(view: RecruitViewController, didFinishRecruit recruitment: Recruitment)
}


class RecruitViewController: UITableViewController {
    
//TODO: Scroll table view when keyboard shows up.
    
    enum EdittingDate {
        case StartDate
        case EndDate
        case NoDate
    }
    
    var dataModel: DataModel!
    
    var recruitment = Recruitment()
    
    var dateToEdit = EdittingDate.NoDate
    var datePickerVisible = false
    
    var delegate: RecruitViewControllerDelegate?
    
    // MARK: - IBOutlet

    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var sportsCategoryLabel: UILabel!
    
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - IBAction
    
    @IBAction func done(sender: AnyObject) {
        recruitment.numberOfPeopleNeeded = numberOfPeopleTextField.text.toInt()!
        recruitment.description = descriptionTextView.text
        if let delegate = self.delegate {
            delegate.recruitViewController(self, didFinishRecruit: recruitment)
        }
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindFromSportCategoryPick(unwindSegue: UIStoryboardSegue) {
        println("unwindFromSportsCategoryPick")
        let sourceViewController = unwindSegue.sourceViewController as! SportsCategoryPickViewController
        recruitment.sportsCategory = sourceViewController.sportsCategory
    }
    
    @IBAction func unwindFromLocationPick(unwindSegue: UIStoryboardSegue) {
        println("unwindFromLocationPick")
        let sourceViewController = unwindSegue.sourceViewController as! LocationPickViewController
        recruitment.location = sourceViewController.pickedLocation
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        recruitment.postDate = NSDate()
        recruitment.sponsor = dataModel.user
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateLabels()
    }

    // MARK: - RecruitViewController methods
    
    func updateLabels() {
        println("updateLabels")
        sportsCategoryLabel.text = recruitment.sportsCategory
        locationLabel.text = recruitment.location
    }
    
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
        numberOfPeopleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    
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
            startDateLabel.textColor = UIColor(red: 22/255, green: 30/255, blue: 62/255, alpha: 0.7)
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
            endDateLabel.textColor = UIColor(red: 22/255, green: 30/255, blue: 62/255, alpha: 0.7)
        default:break
        }

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        hideDatePicker()
        if segue.identifier == "PickSportsCategory" {
            println("prepareForSegue")
            let controller = segue.destinationViewController as! SportsCategoryPickViewController
            controller.sportsCategory = recruitment.sportsCategory
        }
        
        if segue.identifier == "PickLocation" {
            let controller = segue.destinationViewController as! LocationPickViewController
        }
    }
}

// MARK: - UITextViewDelegate

extension RecruitViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        hideDatePicker()
    }
}