//
//  Exercise.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 9/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Exercise: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    @objc dynamic var primaryMuscle = ""
    @objc dynamic var secondaryMuscke = ""
    @objc dynamic var equipment = ""
    @objc dynamic var legend = ""
    @objc dynamic var belongsTo: Routine?
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
