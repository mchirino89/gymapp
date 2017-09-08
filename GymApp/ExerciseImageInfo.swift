//
//  ExerciseImageInfo.swift
//  GymApp
//
//  Created by Mauricio Chirino on 8/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

final class ExerciseImageInfo: Deserializable {
    
    private(set) var info: ExerciseImage?
    
    required init(dictionary: [String : Any]) {
        info <-- dictionary[Constants.JSONResponseKey.exercises.imageJSON]
    }
}
