//
//  ExerciseImage.swift
//  GymApp
//
//  Created by Mauricio Chirino on 8/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

final class ExerciseImage: Deserializable {
    
    private(set) var url: String?
    
    required init(dictionary: [String : Any]) {
        url <-- dictionary[Constants.JSONResponseKey.exercises.imageURL]
    }
}
