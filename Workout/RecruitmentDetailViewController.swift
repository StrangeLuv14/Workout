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

    @IBOutlet weak var sponsorNameLabel: UILabel!
    @IBOutlet weak var sportsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func enroll(sender: AnyObject) {
        
    }
    
    @IBAction func collect(sender: AnyObject) {
    }
    
    @IBAction func cancel(sender: AnyObject) {
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
            sponsorNameLabel.text = recruitment.sponsor
            sportsImageView.image = UIImage(named: recruitment.sportsCategory)
            
            let formatter = NSDateIntervalFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            let startDate = recruitment.startDate
            let endDate = recruitment.endDate
            dateLabel.text = formatter.stringFromDate(startDate, toDate: endDate)
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
