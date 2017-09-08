//
//  TabsController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 29/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class TabsController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstTab = tabBar.items?.first {
            customizeItem(item: firstTab)
        } else {
            print(Constants.ErrorMessages.tabItemError)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        customizeItem(item: item)
    }

    //
    private func customizeItem(item: UITabBarItem) {
        
    }
}
