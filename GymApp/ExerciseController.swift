//
//  ExerciseController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper

class ExerciseController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var exerciseListActivityIndicator: UIActivityIndicatorView!
    
    var muscleGroupList = true
    var dataId:[Int] = []
    var muscleGroupDataSource:ExerciseGroupList?
    
    let muscleLabel = ["Abs", "Arms", "Back", "Calves", "Chest", "Legs", "Shoulders"]
    let exerciseLabel = ["Axe Hold", "Barbell Triceps Extension", "Bench Press Narrow Grip", "Biceps Curls With Barbell", "Biceps Curls With Dumbbell", "Biceps Curls With SZ-bar", "Biceps Curl With Cable", "Body-Ups", "Close-grip Bench Press", "Deadhang", "Dips", "Dips Between Two Benches", "Dumbbell Concentration Curl", "Dumbbell Incline Curl", "Dumbbells on Scott Machine", "Dumbbell Triceps Extension", "French Press (skullcrusher) Dumbbells", "French Press (skullcrusher) SZ-bar", "Hammercurls", "Hammercurls on Cable"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = muscleGroupList ? Constants.MuscleView.title : Constants.ExerciseView.title
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        loadList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From muscles to exercises per muscle
        if segue.destination.isKind(of: ExerciseController.self) {
            guard let destination = segue.destination as? ExerciseController else { return }
            destination.muscleGroupList = false
            destination.dataId.append((sender as? Int) ?? 0)
        } else { // From exercises per muscle to exercise details
            
        }
    }
    
    private func loadList() {
        exerciseListActivityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] _ in
            // Background thread
            if self.muscleGroupList {
                let _ = JSONResponse(kindOfService: .muscleGroup, completion: {
                    (JSONdata) in
                    self.muscleGroupDataSource <-- JSONdata
                    DispatchQueue.main.async {
                        // Coming back to main UI thread
                        self.refreshList()
                    }
                })
            } else { // Exercises' list
                
            }
        }
    }
    
    // Refreshes collection view after API response
    private func refreshList() {
        listCollectionView.reloadData()
        exerciseListActivityIndicator.stopAnimating()
    }
}
