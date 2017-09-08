//
//  DetailController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionTextView: UITextView!
    @IBOutlet weak var configExerciseButton: ButtonStyle!
    
    var exerciseId:Int = 0
    var exerciseName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.DetailView.title
        exerciseNameLabel.text = exerciseName
        JSONResponse(kindOfService: .exerciseDetails(id: exerciseId), completion: {
            (JSONdata) in
            print(JSONdata ?? "No JSON data")
        })
    }
    
}
