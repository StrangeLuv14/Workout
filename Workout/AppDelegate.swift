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


    func fakeData() {
        dataModel.user.username = "Shannon"
        dataModel.user.gender = "Male"
        dataModel.user.userIcon = "Gender Neutral User"
        dataModel.user.description = "I got the vibe."
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        fakeData()
        println("finishLaunch username: \(dataModel.user.username)")
        
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

