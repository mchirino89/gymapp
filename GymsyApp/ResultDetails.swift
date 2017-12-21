//
//  ResultDetails.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 7/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import JSONHelper

final class ResultDetails: Deserializable {
    
    private(set) var id: Int?
    private(set) var name: String?
    
    required init(dictionary: [String : Any]) {
        id <-- dictionary[Constants.JSONResponseKey.exerciseCategory.id]
        name <-- dictionary[Constants.JSONResponseKey.exerciseCategory.name]
    }
}