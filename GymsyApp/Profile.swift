//
//  Profile.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 11/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Profile: Object {
    dynamic var userId = 1
    dynamic var image:Data?
    dynamic var name:String?
    dynamic var gender:String?
    dynamic var age:String?
    dynamic var weight:String?
    dynamic var height:String?
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}
