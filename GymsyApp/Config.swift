//
//  Services.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya

enum Services {
    case muscleGroup
    case exerciseGroup(id: Int)
    case exerciseDetails(id: Int)
}

extension Services: TargetType {
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .muscleGroup, .exerciseDetails(_):
            return .requestPlain
        case .exerciseGroup(let id):
            return .requestParameters(parameters: [Constants.ParameterKey.language: Constants.ParameterValue.language, Constants.ParameterKey.status: Constants.ParameterValue.status, Constants.ParameterKey.category: id], encoding: URLEncoding.queryString)
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
        case .exerciseGroup(_):
            return Constants.Path.exerciseList
        case .exerciseDetails(let id):
            return Constants.Path.exerciseDetails + String(id)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { return Data() }
    var multipartBody: [Moya.MultipartFormData]? { return [] }
    
}
