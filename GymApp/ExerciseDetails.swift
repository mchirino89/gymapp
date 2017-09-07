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
    private(set) var muscles:[ExerciseGroup]?
    private(set) var secondaryMuscles:[ExerciseGroup]?
    private(set) var equipment:[ExerciseGroup]?
    private(set) var description: String?
    
    required init(dictionary: [String : Any]) {
        
    }
}
