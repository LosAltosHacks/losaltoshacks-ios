//
//  AppDelegate.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Application Styles
        UITabBar.appearance().tintColor = LAHColor.DefaultColor.value

        if #available(iOS 9.0, *) {
            UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).font = UIFont.systemFontOfSize(14)
            UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = UIColor(white: 0.4, alpha: 1.0)
        } else {
            UILabel.LAH_appearanceWhenContainedIn(UITableViewHeaderFooterView.self).font = UIFont.systemFontOfSize(14)
            UILabel.LAH_appearanceWhenContainedIn(UITableViewHeaderFooterView.self).textColor = UIColor(white: 0.4, alpha: 1.0)
        }
        
        
        // Push Notifications
        let handleNotification: OneSignalHandleNotificationBlock = { message, data, isActive in
            print("message: \(message)")
            print("additional data: \(data)")
            print("isActive: \(isActive)")
            
            // update cache, on error try again (behind the scenes retries 6 times)
            Update.updateCache(error: { Update.updateCache(error: {print("Failed fetching updates for cache")})})
        }
        
        let client = OneSignal(launchOptions: launchOptions, appId: "3b4705ab-e13e-41e9-8a43-a8371b75b595", handleNotification: handleNotification)
        client.enableInAppAlertNotification(true)
        
        
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

