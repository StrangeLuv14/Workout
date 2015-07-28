//
//  User.swift
//  Workout
//
//  Created by 赵雨 on 7/26/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import Foundation
import UIKit

func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
}

class User {
    static var userId = 0
    
    var username = ""
    var userIcon = UIImage(named: "Default User")
    var description = ""
    var gender = ""
    var id = User.getId()
    
    
    var sponsoredRecruitments = [Recruitment]()
    var enrolledRecruitments = [Recruitment]()
    var collectedRecruitments = [Recruitment]()
    
    class func getId() -> Int {
        return ++userId
    }
}