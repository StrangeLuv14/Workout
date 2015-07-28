//
//  MyProfileViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/26/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class MyProfileViewController: UITableViewController {
    
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    var dataModel: DataModel!
    
    
    
    @IBAction func done(sender: UIStoryboardSegue) {
        let sourceViewController = sender.sourceViewController as! SettingsViewController
        updateUI()
        println("Unwind to MyProfile")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIconImageView.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPhotoMenu")
        userIconImageView.addGestureRecognizer(tapGestureRecognizer)
        
        updateUI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func updateUI() {
        userIconImageView.image = dataModel.user.userIcon
        genderImageView.image = UIImage(named: dataModel.user.gender)
        usernameLabel.text = dataModel.user.username
        userDescriptionLabel.text = dataModel.user.description
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        switch (indexPath.section, indexPath.row) {
        case (1, _):
            performSegueWithIdentifier("ShowMyRecruitments", sender: indexPath)
        default:break
        }
    }
    
    // MARK: - Table view data source
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSettings" {
            let controller = segue.destinationViewController as! SettingsViewController
            controller.dataModel = dataModel
        }
        
        if segue.identifier == "ShowMyRecruitments" {
            println("ShowMyRecruitments")
            let controller = segue.destinationViewController as! MyRecruitmentsViewController
            controller.dataModel = dataModel
            if let indexPath = sender as? NSIndexPath {
                switch (indexPath.section, indexPath.row) {
                case (1, 0):
                    controller.recruitmentsKind = .MyRecruitments
                    println("\(controller.title)")
                case (1, 1):
                    controller.recruitmentsKind = .Enrollments  
                    println("\(controller.title)")
                case (1, 2):
                    controller.recruitmentsKind = .Collection
                    println("\(controller.title)")
                default:
                    println("fatal Error！")
                    break
                }
            }
            
        }
    }
    
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        userIconImageView.image = newUserIcon
        dataModel.user.userIcon = newUserIcon
        tableView.reloadData()
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
