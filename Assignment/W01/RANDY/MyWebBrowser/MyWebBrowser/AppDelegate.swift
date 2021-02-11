//
//  AppDelegate.swift
//  MyWebBrowser
//
//  Created by Randy on 2021/02/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let userDefaultsURLKey : String = "lastURL"
    var lastURL : URL?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.lastURL = UserDefaults.standard.url(forKey: AppDelegate.userDefaultsURLKey)
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func applicationWillResignActive(_ application: UIApplication) {
        if lastURL != nil {
            UserDefaults.standard.set(self.lastURL,forKey: AppDelegate.userDefaultsURLKey)
            UserDefaults.standard.synchronize()
        }
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(self.lastURL,forKey: AppDelegate.userDefaultsURLKey)
        UserDefaults.standard.synchronize()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

