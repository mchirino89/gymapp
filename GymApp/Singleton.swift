//
//  Singleton.swift
//  GymApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya

class Singleton {
    static let provider = MoyaProvider<Services>()
    private init() {}
    
    func JSONResponse(kindOfService: Services, completion: (_ response: AnyObject?) ->()) -> Cancellable {
        <#function body#>
    }
}
