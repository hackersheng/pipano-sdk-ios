//
//  AppDelegate.swift
//  TestSwift
//
//  Created by forty Lin on 2017/10/27.
//  Copyright © 2017年 forty. All rights reserved.
//

import UIKit

class AppDelegate: UnityAppController {
    var navigationController: UINavigationController?
    
    override func willStart(with controller: UIViewController)
    {
        super.willStart(with: controller)
        
        PiPano.onPiPanoSDKReady({
            NSLog("PiPanoSDK is ok")
            PiPano.setLanguage("en")
        })
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "idMainViewController") as? MainViewController
        self.navigationController = UINavigationController(rootViewController: mainVC!)
        //    [_rootView addSubview:self.navigationController.view];
        setMainView(mainVC, mainViewNavigationCtler: self.navigationController)
    }


    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

   override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        super.applicationWillResignActive(application)
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        super.applicationDidEnterBackground(application)
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        super.applicationDidEnterBackground(application)
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        super.applicationDidBecomeActive(application)
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        super.applicationWillTerminate(application)
    }


}

