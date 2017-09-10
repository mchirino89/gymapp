//
//  Singleton.swift
//  GymApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya
import RealmSwift

final class Singleton {
    static let provider = MoyaProvider<Services>()
    static let imageCache = NSCache<NSString, NSData>()
    static var dataSource:Realm!
    static var selectedRoutine:Results<Exercise>?
    private init() {}
}
