//
//  RoutineController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import RealmSwift

final class RoutineController: UIViewController {
    
    @IBOutlet weak var routineTableView: UITableView!
    var routineDataSource:[Routine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        routineDataSource.append(contentsOf: Singleton.dataSource.objects(Routine.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exerciseView = segue.destination as? ExerciseController, let parameters = sender as? [Any] else { return }
        exerciseView.muscleGroupList = 2
        exerciseView.dataId = parameters.first as? Int ?? 0
        exerciseView.viewTitle = parameters.last as? String
    }
}
