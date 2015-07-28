//
//  MainPageViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class MainPageViewController: UITableViewController {
    
    var dataModel: DataModel!
    var user = User()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let cellNib = UINib(nibName: "RecruitmentCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "RecruitmentCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        //FIXME: tableview cell not updated
        println("ViewWillAppear")
        println("")
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataModel.recruitments.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecruitmentCell", forIndexPath: indexPath) as! RecruitmentCell

        // Configure the cell...
        println("cellForRowAtIndexPath")
        let recruitment = dataModel.recruitments[indexPath.row]
        cell.configureForRecruitment(recruitment)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetail", sender: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let controller = segue.destinationViewController as! RecruitmentDetailViewController
            controller.recruitment = dataModel.recruitments[sender!.row]
            controller.dataModel = dataModel
        }
        
        if segue.identifier == "Recruit" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! RecruitViewController
            controller.dataModel = dataModel
            controller.delegate = self
        }
    }
}

extension MainPageViewController: RecruitViewControllerDelegate {
    func recruitViewController(view: RecruitViewController, didFinishRecruit recruitment: Recruitment) {
        dataModel.recruitments.append(recruitment)
        dataModel.user.sponsoredRecruitments.append(recruitment)
    }
}
