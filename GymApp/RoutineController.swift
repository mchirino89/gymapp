//
//  RoutineController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

final class RoutineController: UIViewController {
    @IBOutlet weak var routineTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exerciseView = segue.destination as? ExerciseController else { return }
        exerciseView.muscleGroupList = false
        exerciseView.dataId.append((sender as? Int) ?? 0)
    }
}
