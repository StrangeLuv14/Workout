//
//  SportsCategoryPickViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class SportsCategoryPickViewController: UITableViewController {
    
    var sportsCategories = [
        "Baseball",
        "Basketball",
        "Bowling",
        "Dumbbell",
        "Fishing",
        "Football",
        "Ping Pong",
        "Regular Biking",
        "Swimming",
        "Tennis",
        "Volleyball",
        "Yoga"]
    
    var sportsCategory = ""

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
        return sportsCategories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SportsCategoryCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let sportsName = sportsCategories[indexPath.row]
        cell.textLabel?.text = sportsName
        cell.imageView?.image = UIImage(named: sportsName)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sportsCategory = sportsCategories[indexPath.row]
        performSegueWithIdentifier("DonePickLocation", sender: nil)
    }

}

