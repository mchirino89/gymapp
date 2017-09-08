//
//  Muscle.swift
//  GymApp
//
//  Created by Mauricio Chirino on 7/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

class Muscle: Deserializable {
    
    private(set) var result:[ExerciseGroup]?
    
    required init(dictionary: [String : Any]) {
        result <-- dictionary[Constants.JSONResponseKey.results]
    }
}
