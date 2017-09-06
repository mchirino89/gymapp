//
//  ExerciseController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class ExerciseController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var kindOfList = 0
    var dataId:Int?
    let muscleLabel = ["Abs", "Arms", "Back", "Calves", "Chest", "Legs", "Shoulders"]
    let exerciseLabel = ["Axe Hold", "Barbell Triceps Extension", "Bench Press Narrow Grip", "Biceps Curls With Barbell", "Biceps Curls With Dumbbell", "Biceps Curls With SZ-bar", "Biceps Curl With Cable", "Body-Ups", "Close-grip Bench Press", "Deadhang", "Dips", "Dips Between Two Benches", "Dumbbell Concentration Curl", "Dumbbell Incline Curl", "Dumbbells on Scott Machine", "Dumbbell Triceps Extension", "French Press (skullcrusher) Dumbbells", "French Press (skullcrusher) SZ-bar", "Hammercurls", "Hammercurls on Cable"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = kindOfList == 0 ? Constants.MuscleView.title : Constants.ExerciseView.title
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        let _ = JSONResponse(kindOfService: .muscleGroup, completion: {
            (JSONdata) in
            print(JSONdata ?? "No data returned")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From muscles to exercises per muscle
        if segue.destination.isKind(of: ExerciseController.self) {
            guard let destination = segue.destination as? ExerciseController else { return }
            destination.kindOfList = 1
            destination.dataId = sender as? Int
        } else { // From exercises per muscle to exercise details
            
        }
    }
}
