//
//  AppDelegate.swift
//  Workout
//
//  Created by 赵雨 on 7/23/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataModel = DataModel()


    func fakeUser() {
        dataModel.user.username = "Shannon"
        dataModel.user.gender = "Male"
        dataModel.user.description = "I got the vibe."
    }
    
    func fakeData() {
        let recruitment1 = Recruitment()
        let user1 = User()
        
        user1.username = "Marvin Gaye"
        user1.gender = "Male"
        user1.description = "Let's stay together!"
        recruitment1.sponsor = user1
        recruitment1.sportsCategory = "Dumbbell"
        recruitment1.numberOfPeopleNeeded = 3
        recruitment1.postDate = NSDate(timeIntervalSinceNow: 1000)
        recruitment1.startDate = NSDate(timeInterval: 1000, sinceDate:recruitment1.postDate)
        recruitment1.endDate = NSDate(timeInterval: 1000, sinceDate: recruitment1.startDate)
        recruitment1.location = "Jungle Fever Bar"
        recruitment1.description = "Just love workout."
        dataModel.recruitments.append(recruitment1)
        
        let recruitment2 = Recruitment()
        let user2 = User()
        
        user2.username = "The Supremes"
        user2.gender = "Female"
        user2.description = "Diana Ross just start soloing!"
        recruitment2.sponsor = user2
        recruitment2.sportsCategory = "Yoga"
        recruitment2.numberOfPeopleNeeded = 2
        recruitment2.postDate = NSDate(timeIntervalSinceNow: 2000)
        recruitment2.startDate = NSDate(timeInterval: 2000, sinceDate:recruitment2.postDate)
        recruitment2.endDate = NSDate(timeInterval: 2000, sinceDate: recruitment2.startDate)
        recruitment2.location = "Soul Train"
        recruitment2.description = "Need to calm down."
        dataModel.recruitments.append(recruitment2)
        
        
        let recruitment3 = Recruitment()
        let user3 = User()
        user3.username = "2 Pac"
        user3.gender = "Male"
        user3.description = "Life goes on!"
        recruitment3.sponsor = user3
        recruitment3.sportsCategory = "Basketball"
        recruitment3.numberOfPeopleNeeded = 1
        recruitment3.postDate = NSDate(timeIntervalSinceNow: 3000)
        recruitment3.startDate = NSDate(timeInterval: 3000, sinceDate:recruitment3.postDate)
        recruitment3.endDate = NSDate(timeInterval: 3000, sinceDate: recruitment3.startDate)
        recruitment3.location = "The park"
        recruitment3.description = "And One."
        dataModel.recruitments.append(recruitment3)
        
        let recruitment4 = Recruitment()
        let user4 = User()
        user4.username = "Biggie"
        user4.gender = "Male"
        user4.description = "Juicy!"
        recruitment4.sponsor = user4
        recruitment4.sportsCategory = "Fishing"
        recruitment4.numberOfPeopleNeeded = 2
        recruitment4.postDate = NSDate(timeIntervalSinceNow: 4000)
        recruitment4.startDate = NSDate(timeInterval: 4000, sinceDate:recruitment4.postDate)
        recruitment4.endDate = NSDate(timeInterval: 4000, sinceDate: recruitment4.startDate)
        recruitment4.location = "Brooklyn River"
        recruitment4.description = "Just like to eat fish."
        dataModel.recruitments.append(recruitment4)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        fakeUser()
        fakeData()
        let tabBarController = window?.rootViewController as? UITabBarController
        if let tabBarControllers = tabBarController?.viewControllers {
            var navigationController = tabBarControllers[0] as! UINavigationController
            let mainPageViewController = navigationController.topViewController as! MainPageViewController
            mainPageViewController.dataModel = dataModel
            
            navigationController = tabBarControllers[1] as! UINavigationController
            let myProfileViewController = navigationController.topViewController as! MyProfileViewController
            myProfileViewController.dataModel = dataModel
        }
        
        // Override point for customization after application launch.
        return true

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

