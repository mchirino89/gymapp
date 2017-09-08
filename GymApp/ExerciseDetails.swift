//
//  ExerciseDetails.swift
//  GymApp
//
//  Created by Mauricio Chirino on 7/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

class ExerciseDetails: Deserializable {
    
    private(set) var category:ExerciseGroup?
    private(set) var muscles:ExerciseGroupList?
    private(set) var secondaryMuscles:ExerciseGroupList?
    private(set) var equipment:ExerciseGroupList?
    private(set) var description: String?
    
    required init(dictionary: [String : Any]) {
        category = ExerciseGroup(dictionary: dictionary)
        muscles = ExerciseGroupList(dictionary: dictionary)
        secondaryMuscles = ExerciseGroupList(dictionary: dictionary)
        equipment = ExerciseGroupList(dictionary: dictionary)
        description <-- dictionary[Constants.JSONResponseKey.exercises.description]
    }
}
