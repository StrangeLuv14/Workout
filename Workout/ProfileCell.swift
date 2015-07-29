//
//  ProfileCell.swift
//  Workout
//
//  Created by 赵雨 on 7/29/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate: class {
    func profileCellDidSelectUserIcon(cell: ProfileCell)
}

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    var delegate: ProfileCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userIconImageView.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "selectUserIcon")
        userIconImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCellForUser(user: User) {
        userIconImageView.image = user.userIcon
        genderImageView.image = UIImage(named: user.gender)
        usernameLabel.text = user.username
        userDescriptionLabel.text = user.description
    }
    
    func selectUserIcon() {
        if let delegate = delegate {
            delegate.profileCellDidSelectUserIcon(self)
        }
    }

}

