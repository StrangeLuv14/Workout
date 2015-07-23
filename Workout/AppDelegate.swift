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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let darkBlueColor = UIColor(red: 22/255, green: 30/255, blue: 62/255, alpha: 1.0)
        let lightBlueColor = UIColor(red: 40/255, green: 81/255, blue: 113/255, alpha: 1.0)
        let lightGreenColor = UIColor(red: 130/255, green: 192/255, blue: 175/255, alpha: 1.0)
        let darkYellowColor = UIColor(red: 216/255, green: 179/255, blue: 104/255, alpha: 1.0)
        let lightYellowColor = UIColor(red: 218/255, green: 212/255, blue: 185/255, alpha: 1.0)
        
        /*
        window?.tintColor = darkBlueColor
        UINavigationBar.appearance().barTintColor = lightBlueColor
        UINavigationBar.appearance().tintColor = darkBlueColor
        
        UILabel.appearance().tintColor = darkBlueColor
        
        //UIView.appearance().backgroundColor = lightYellowColor
        
        UITabBar.appearance().barTintColor = lightBlueColor
        UITableView.appearance().backgroundColor = darkYellowColor
        UITableViewCell.appearance().backgroundColor = lightYellowColor
        */
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

