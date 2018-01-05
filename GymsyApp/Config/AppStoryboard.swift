//
//  AppStoryboards.swift
//  AppStoryboards
//
//  Created by Gurdeep  on 15/12/16.
//  Powered by Mauricio on 04/01/18.
//  Copyright © 2016 Gurdeep. All rights reserved.
//  https://gist.github.com/Gurdeep0602/4fc3892c1b2861d4cd2062ddfddf3262
//

import UIKit

enum AppStoryboard : String {
    
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("""

                ViewController with identifier \(storyboardID) not found in \(self.rawValue) Storyboard.
                Function : \(function)
                Line Number : \(line)
                File : \(file)
                
            """)
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
