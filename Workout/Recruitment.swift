//
//  Recruitment.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import Foundation
import Swift

func == (lhs: Recruitment, rhs: Recruitment) -> Bool {
    return lhs.id == rhs.id
}

extension Recruitment: Equatable {}

class Recruitment {
    enum Gender : Int{
        case Male = 0
        case Female = 1
    }
    
    static var recruitmentId = 0
    
    var sponsor = User()
    var gender = Recruitment.Gender.Male
    
    var id = Recruitment.getId()
    var sportsCategory = ""
    var numberOfPeopleNeeded = 0
    var numberOfPeopleRecruited = 0
    
    
    var postDate = NSDate()
    var startDate = NSDate()
    var endDate = NSDate()
    var location = ""
    var description = ""
    var enrolled = false
    var collected = false
    
    //func ==(lhs: Self, rhs: Self) -> Bool

    
    func stringForGender() -> String {
        switch gender {
        case .Male: return "Male"
        case .Female: return "Female"
        }
    }
    
    
    class func getId() -> Int {
        return ++recruitmentId
    }
    /*
    enum sportsCategory: String {
        case Baseball = "Baseball"
        case Basketball = "basketball"
        case Bowling = "Bowling"
        case Dumbbell = "Dumbbell"
        case Fishing = "Fishing"
        case Football = "Football"
        case PingPong = "Ping Pong"
        case Biking = "Regular Biking"
        case Swimming = "Swimming"
        case Tennis = "Tennis"
        case Volleyball = "Volleyball"
        case Yoga = "Yoga"
    }
    */
    
}