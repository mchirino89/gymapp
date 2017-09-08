//
//  DetailController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper

class DetailController: UIViewController {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionTextView: UITextView!
    @IBOutlet weak var configExerciseButton: ButtonStyle!
    @IBOutlet weak var loadingVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var mainMuscleLabel: UILabel!
    @IBOutlet weak var secondaryMusclesLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var exerciseId:Int = 0
    var exerciseName:String = ""
    var exerciseInfo:ExerciseDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.DetailView.title
        exerciseNameLabel.text = exerciseName
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let view = self else { return }
            JSONResponse(kindOfService: .exerciseDetails(id: view.exerciseId), completion: { (JSONdata) in
                view.exerciseInfo <-- JSONdata
                DispatchQueue.main.async {
                    view.categoryLabel.text?.append(view.exerciseInfo!.category!.name!)
                    view.exerciseDescriptionTextView.text = view.exerciseInfo?.description
                    view.mainMuscleLabel.text?.append(view.makeListSentence(list: view.exerciseInfo?.muscles?.result))
                    view.secondaryMusclesLabel.text?.append(view.makeListSentence(list: view.exerciseInfo?.secondaryMuscles?.result))
                    view.equipmentLabel.text?.append(view.makeListSentence(list: view.exerciseInfo?.equipment?.result))
                    view.loadingVisualEffectView.isHidden = true
                }
            })
        }
    }
    
    private func makeListSentence(list: [ResultDetails]?) -> String {
        guard let response = list else { return "" }
        switch response.count {
        case 0:
            return Constants.UIElements.nonApplicable
        case 1:
            return response.first!.name!
        case 2:
            return response.first!.name! + Constants.UIElements.connector + response.last!.name!
        default:
            var currentIndex = 0
            var sentence = ""
            response.forEach { word in
                if currentIndex + 1 == response.count {
                    return
                }
                currentIndex += 1
                sentence = word.name! + ", "
            }
            return sentence + Constants.UIElements.connector + response.last!.name!
        }
    }
    
}
