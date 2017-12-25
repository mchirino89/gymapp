//
//  Profile.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 11/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

class Profile: Object {
    @objc dynamic var userId = 1
    @objc dynamic var image:Data?
    @objc dynamic var name:String?
    @objc dynamic var gender:String?
    @objc dynamic var age:String?
    @objc dynamic var weight:String?
    @objc dynamic var height:String?
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}
