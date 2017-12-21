//
//  ExerciseDetails.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 7/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

final class ExerciseDetails: Deserializable {
    
    private(set) var category:ResultDetails?
    private(set) var muscles:ResultList?
    private(set) var secondaryMuscles:ResultList?
    private(set) var equipment:ResultList?
    private(set) var description: String?
    
    required init(dictionary: [String : Any]) {
        category = ResultDetails(dictionary: dictionary[Constants.ParameterKey.category] as! [String : Any])
        muscles = ResultList(dictionary: dictionary, kindOfResult: Constants.kindOfResult.mainMuscle.rawValue)
        secondaryMuscles = ResultList(dictionary: dictionary, kindOfResult: Constants.kindOfResult.secondaryMuscles.rawValue)
        equipment = ResultList(dictionary: dictionary, kindOfResult: Constants.kindOfResult.equipment.rawValue)
        description <-- dictionary[Constants.JSONResponseKey.exercises.description]
        description = description!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
