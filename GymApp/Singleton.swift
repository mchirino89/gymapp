//
//  Singleton.swift
//  GymApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya

final class Singleton {
    static let provider = MoyaProvider<Services>()
    static let dataSources:Routines = Routines()
    static let imageCache = NSCache<NSString, NSData>()
    private init() {}
}
