//
//  MyEnrollmentViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/28/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class MyRecruitmentsViewController: UITableViewController {
    
    enum RecruitmentKind {
        case MyRecruitments
        case Enrollments
        case Collection
    }
    
    var dataModel: DataModel?
    
    var recruitmentsKind: RecruitmentKind?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RecruitmentCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "RecruitmentCell")
        
        if let recruitmentsKind = recruitmentsKind {
            switch recruitmentsKind {
            case .MyRecruitments:
                self.title = "MyRecruitments"
            case .Enrollments:
                self.title = "MyEnrollments"
            case .Collection:
                self.title = "MyCollection"
            default:break
            }
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch recruitmentsKind! {
        case .MyRecruitments:
            return dataModel!.user.sponsoredRecruitments.count
        case .Enrollments:
            return dataModel!.user.enrolledRecruitments.count
        case .Collection:
            return dataModel!.user.collectedRecruitments.count
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RecruitmentCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecruitmentCell", forIndexPath: indexPath) as! RecruitmentCell

        // Configure the cell...
        var recruitment = Recruitment()
        switch recruitmentsKind! {
        case .MyRecruitments:
            recruitment = dataModel!.user.sponsoredRecruitments[indexPath.row]
        case .Enrollments:
            recruitment = dataModel!.user.enrolledRecruitments[indexPath.row]
        case .Collection:
            recruitment = dataModel!.user.collectedRecruitments[indexPath.row]
        }
        cell.configureForRecruitment(recruitment)

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetail", sender: indexPath)
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



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail" {
            let controller = segue.destinationViewController as! RecruitmentDetailViewController
            controller.dataModel = dataModel
            var recruitment = Recruitment()
            switch recruitmentsKind! {
            case .MyRecruitments:
                recruitment = dataModel!.user.sponsoredRecruitments[sender!.row]
            case .Enrollments:
                recruitment = dataModel!.user.enrolledRecruitments[sender!.row]
            case .Collection:
                recruitment = dataModel!.user.collectedRecruitments[sender!.row]
            }
            controller.recruitment = recruitment
        }
    }

}
