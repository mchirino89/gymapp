//
//  Services.swift
//  GymApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya

extension Services: TargetType {
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .muscleGroup:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [Constants.ParameterKey.contentType:
                Constants.ParameterValue.contentType]
    }
    
    var baseURL: URL { return URL(string: Constants.APIConfiguration.rootURL)! }
    
    var path: String {
        switch self {
        case .muscleGroup:
            return Constants.Path.exerciseGroup
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { return Data() }
    var multipartBody: [Moya.MultipartFormData]? { return [] }
    
}
