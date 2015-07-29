//
//  MyProfileViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/26/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class MyProfileViewController: UITableViewController {
    
    
    
    var dataModel: DataModel!
    var recruitmentsKind = RecruitmentsKind.Sponsorship
    
    
    
    @IBAction func done(sender: UIStoryboardSegue) {
        let sourceViewController = sender.sourceViewController as! SettingsViewController
        println("Unwind to MyProfile")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "ProfileCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ProfileCell")
        
        
        nib = UINib(nibName: "RecruitmentsKindCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "RecruitmentsKindCell")
        
        nib = UINib(nibName: "RecruitmentCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "RecruitmentCell")
        

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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var recruitmentsCount = 0
        switch recruitmentsKind {
        case .Sponsorship:
            recruitmentsCount = dataModel.user.sponsoredRecruitments.count
        case .Enrollment:
            recruitmentsCount = dataModel.user.enrolledRecruitments.count
        case .Collection:
            recruitmentsCount = dataModel.user.collectedRecruitments.count
        }
        return 2 + recruitmentsCount
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 44
        } else {
            return 88
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("cellForRowAtIndexPath")
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.configureCellForUser(dataModel.user)
            cell.delegate = self
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecruitmentsKindCell", forIndexPath: indexPath) as! RecruitmentsKindCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecruitmentCell", forIndexPath: indexPath) as! RecruitmentCell

            switch recruitmentsKind {
            case .Sponsorship:
                let recruitment = dataModel.user.sponsoredRecruitments[indexPath.row - 2]
                cell.configureForRecruitment(recruitment)
                return cell
            case .Enrollment:
                let recruitment = dataModel.user.enrolledRecruitments[indexPath.row - 2]
                cell.configureForRecruitment(recruitment)
                return cell
            case .Collection:
                let recruitment = dataModel.user.collectedRecruitments[indexPath.row - 2]
                cell.configureForRecruitment(recruitment)
                return cell
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > 1 {
            performSegueWithIdentifier("ShowRecruitment", sender: indexPath)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSettings" {
            let controller = segue.destinationViewController as! SettingsViewController
            controller.dataModel = dataModel
        }
        
        if segue.identifier == "ShowRecruitment" {
            let controller = segue.destinationViewController as! RecruitmentDetailViewController
            controller.recruitment = dataModel.recruitments[sender!.row]
            controller.dataModel = dataModel
            
        }
        
    }
    
}

extension MyProfileViewController: RecruitmentsKindCellDelegate {
    func recruitmentsKindCell(cell: RecruitmentsKindCell, didSelectRecruitmentsKind kind: RecruitmentsKind) {
        recruitmentsKind = kind
        tableView.reloadData()
    }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileCellDelegate {
    
    func profileCellDidSelectUserIcon(cell: ProfileCell) {
        showPhotoMenu()
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func takePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler: {
            _ in self.takePhotoWithCamera()
        })
        alertController.addAction(takePhotoAction)
        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .Default, handler: {
            _ in self.takePhotoFromLibrary()
        })
        alertController.addAction(chooseFromLibraryAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let newUserIcon = info[UIImagePickerControllerEditedImage] as! UIImage?
        dataModel.user.userIcon = newUserIcon
        tableView.reloadData()
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
