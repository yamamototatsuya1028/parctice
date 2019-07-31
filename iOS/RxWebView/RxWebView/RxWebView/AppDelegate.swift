//
//  AppDelegate.swift
//  RxWebView
//
//  Created by yamamoto.tatsuya on 2019/07/30.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let storyboard = UIStoryboard(name: "WKViewController", bundle: nil)
//        let VC = storyboard.instantiateViewController(withIdentifier: "WKViewController")
        let navi = UINavigationController(rootViewController: RxWebViewViewController())
        self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()
        return true
    }


}

