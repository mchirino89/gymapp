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
        return routineDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.routineCell) as? RoutineViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: Constants.Storyboard.routineCell)
        }
        cell.routineLabel.text = routineDataSource[indexPath.row].name
        cell.backgroundImageView.image = UIImage(named: routineDataSource[indexPath.row].imageName)
        cell.idForRoutine = routineDataSource[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let routineCell = tableView.cellForRow(at: indexPath) as? RoutineViewCell else { return }
        Singleton.selectedRoutine = Singleton.dataSource.objects(Exercise.self).filter("belongsTo == %@", routineDataSource[indexPath.row])
        performSegue(withIdentifier: Constants.Storyboard.routineDetailSegue, sender: [routineCell.idForRoutine as Any, routineCell.routineLabel.text as Any])
    }
}
