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
        Singleton.provider.request(.muscleGroup, completion: {
            result in
            print(result.description)
            print(result.value ?? "no value")
            print(result.value?.data ?? "no data")
            switch result {
                case .success:
                    let data = result.value?.data
                    let statusCode = result.value?.statusCode
                    print(data as Any)
                    print(statusCode ?? 0)
                case let .failure(error):
                    print(error.errorDescription as Any)
                    print(error.failureReason as Any)
                    print(error.response as Any)
                    print(error.helpAnchor as Any)
                    print(error.localizedDescription as Any)
                    print(error.recoverySuggestion as Any)
                }
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
