//
//  AppDelegate.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        window?.makeKeyAndVisible()
        setuoGoogle()
        configureApp()
        ApplicationFlow.shared.start()
        return true
    }

    fileprivate func configureApp() {
        NetworkManager.shared.startNetworkReachabilityObserver()
        SDImageCache.shared.config.maxDiskSize = 100 * 1024 * 1024
        SDImageCache.shared.config.maxMemoryCost = 15 * 1024 * 1024
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AppDelegate.rotated),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    func setuoGoogle() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            fatalError("Bug rotation")
        }

        if UIDevice.current.orientation.isPortrait {
            print("Portrait")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //fatalError()
    }
}


