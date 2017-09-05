//
//  TableView.swift
//  GymApp
//
//  Created by Mauricio Chirino on 4/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension RoutineController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.routineCell) as? RoutineViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: Constants.Storyboard.routineCell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let routineCell = tableView.cellForRow(at: indexPath) as? RoutineViewCell else { return }
        performSegue(withIdentifier: Constants.Storyboard.routineDetailSegue, sender: routineCell.idForRoutine)
    }
}
