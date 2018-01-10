//
//  Services.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 6/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Moya

enum Services {
    case categories
    case muscleGroup
    case exerciseGroup(id: Int)
    case exerciseDetails(id: Int)
}

extension Services: TargetType {
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .muscleGroup, .categories, .exerciseDetails(_):
            return .requestPlain
        case .exerciseGroup(let id):
            return .requestParameters(parameters: [Constants.ParameterKey.language: Constants.ParameterValue.language, Constants.ParameterKey.status: Constants.ParameterValue.status, Constants.ParameterKey.category: id], encoding: URLEncoding.queryString)
        }
    }

//    var headers: [String: String]? {
//        return [Constants.ParameterKey.contentType:
//                Constants.ParameterValue.contentType]
//    }
    
    var headers: [String: String]? {
        return [Constants.ParametersKey.accessKey: Constants.ParametersValue.accessKey,
                Constants.ParametersKey.randomKey: Constants.ParametersValue.randomKey]
    }
    
//    var baseURL: URL { return URL(string: Constants.APIConfiguration.rootURL)! }
    var baseURL: URL { return URL(string: Constants.APIConfiguration.development)! }
    
    var path: String {
        switch self {
        case .categories:
            return Constants.Endpoints.categories
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
