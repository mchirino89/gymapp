//
//  Muscle.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 9/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Muscle: Object {
    dynamic var id = 0
    dynamic var name = ""
    let exercises = List<Exercise>()
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
