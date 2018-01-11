//
//  Singleton.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya
import RealmSwift

final class Singleton {
    static let decoder = JSONDecoder()
    static let imageCache = NSCache<NSString, NSData>()
    static let provider = MoyaProvider<Services>()
    static var selectedRoutine: Results<Exercise>?
    static var dataSource: Realm!
    static var appsLanguage = Constants.language.english
    private init() { }
}
