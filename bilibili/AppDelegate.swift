//
//  AppDelegate.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/29.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = TabbarController()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

