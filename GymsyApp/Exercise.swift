//
//  Exercise.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 9/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Exercise: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var category = ""
    dynamic var primaryMuscle = ""
    dynamic var secondaryMuscke = ""
    dynamic var equipment = ""
    dynamic var legend = ""
    dynamic var belongsTo: Routine?
//    let belongsTo = LinkingObjects(fromType: Routine.self, property: "exercises")
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
