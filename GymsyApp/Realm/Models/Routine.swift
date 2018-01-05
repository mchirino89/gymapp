//
//  Routine.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 9/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Routine: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var imageName = ""
    let exercises = List<Exercise>()
    
    convenience init(id: Int, name: String, imageName: String) {
        self.init()
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
