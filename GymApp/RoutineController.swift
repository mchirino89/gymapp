//
//  RoutineController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class RoutineController: UIViewController {
    @IBOutlet weak var routineTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
    }
}
