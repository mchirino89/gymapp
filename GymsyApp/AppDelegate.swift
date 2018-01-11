//
//  AppDelegate.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        preFillRealm()
        guard let devicesLanguage: String = Locale.preferredLanguages.first?.uppercased()
            else { return true }
        print(devicesLanguage)
        Singleton.appsLanguage = devicesLanguage.contains(Constants.language.spanish.rawValue) ? .spanish : .english
        return true
    }
}

