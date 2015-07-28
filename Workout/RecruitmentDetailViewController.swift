//
//  RecruitmentDetailViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

class RecruitmentDetailViewController: UIViewController {
    
    var recruitment: Recruitment?
    var dataModel: DataModel!

    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var sponsorNameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var sportsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var numberOfPeopleRecruitedLabel: UILabel!
    @IBOutlet weak var enrollButton: UIButton!
    @IBOutlet weak var collectButton: UIButton!
    
    @IBAction func enroll(sender: AnyObject) {
        if let recruitment = recruitment {
            if !recruitment.enrolled {
                recruitment.enrolled = true
                enrollButton.setTitle("Enrolled", forState: .Normal)
                let numberOfPeopleAvailable = recruitment.numberOfPeopleNeeded - recruitment.numberOfPeopleRecruited
                if numberOfPeopleAvailable != 0 {
                    recruitment.numberOfPeopleRecruited++
                    dataModel.user.enrolledRecruitments.append(recruitment)
                    println("Enrolled!")
                } else {
                    println("Enroll failed!")
                }
            } else {
                recruitment.enrolled = false
                enrollButton.setTitle("Enroll", forState: .Normal)
                if let index = find(dataModel.user.enrolledRecruitments, recruitment) {
                    recruitment.numberOfPeopleRecruited--
                    dataModel.user.enrolledRecruitments.removeAtIndex(index)
                    println("Cancel enroll!")
                } else {
                    println("Cancel Enroll failed!")
                }
            }
        }
        configureUI()
    }
    
    @IBAction func collect(sender: AnyObject) {
        if let recruitment = recruitment {
            if !recruitment.collected {
                recruitment.collected = true
                collectButton.setTitle("Collected", forState: .Normal)
                dataModel.user.collectedRecruitments.append(recruitment)
                
                
            } else {
                recruitment.collected = false
                collectButton.setTitle("Collect", forState: .Normal)
                if let index = find(dataModel.user.collectedRecruitments, recruitment) {
                    dataModel.user.collectedRecruitments.removeAtIndex(index)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureUI() {
        if let recruitment = recruitment {
            
            if recruitment.sponsor == dataModel!.user {
                hideButtons()
            } else {
                showButtons()
            }
            
            userIconImageView.image = recruitment.sponsor.userIcon
            sponsorNameLabel.text = recruitment.sponsor.username
            numberOfPeopleLabel.text = String(recruitment.numberOfPeopleNeeded)
            numberOfPeopleRecruitedLabel.text = String(recruitment.numberOfPeopleRecruited)
            let gender = recruitment.stringForGender()
            genderImageView.image = UIImage(named: gender)
            sportsImageView.image = UIImage(named: recruitment.sportsCategory)
            
            let formatter = NSDateIntervalFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            let startDate = recruitment.startDate
            let endDate = recruitment.endDate
            dateLabel.text = formatter.stringFromDate(startDate, toDate: endDate)
            
            locationLabel.text = recruitment.location
            descriptionTextView.text = recruitment.description
            
        }
    }
    
    private func hideButtons() {
        enrollButton.hidden = true
        collectButton.hidden = true
    }
    
    private func showButtons() {
        if let recruitment = recruitment {
            enrollButton.hidden = false
            collectButton.hidden = false
            enrollButton.setTitle(recruitment.enrolled ? "Enrolled" : "Enroll", forState: .Normal)
            collectButton.setTitle(recruitment.collected ? "Collected" : "Collect", forState: .Normal)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
