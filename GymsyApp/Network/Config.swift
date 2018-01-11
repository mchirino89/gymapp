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
            case .muscleGroup, .exerciseDetails(_):
                return .requestPlain
            case .exerciseGroup(let id):
                return .requestParameters(parameters: [Constants.parameterKey.language: Constants.parameterValue.language, Constants.parameterKey.status: Constants.parameterValue.status, Constants.parameterKey.category: id], encoding: URLEncoding.queryString)
            default:
                return .requestParameters(parameters: [Constants.parametersKey.language: Singleton.appsLanguage.rawValue], encoding: URLEncoding.queryString)
        }
    }

//    var headers: [String: String]? {
//        return [Constants.parameterKey.contentType:
//                Constants.parameterValue.contentType]
//    }
    
    var headers: [String: String]? {
        return [Constants.parametersKey.accessKey: Constants.parametersValue.accessKey,
                Constants.parametersKey.randomKey: Constants.parametersValue.randomKey]
    }
    
//    var baseURL: URL { return URL(string: Constants.apiConfiguration.rootURL)! }
    var baseURL: URL { return URL(string: Constants.apiConfiguration.development)! }
    
    var path: String {
        switch self {
        case .categories:
            return Constants.endPoints.categories
        case .muscleGroup:
            return Constants.path.exerciseGroup
        case .exerciseGroup(_):
            return Constants.path.exerciseList
        case .exerciseDetails(let id):
            return Constants.path.exerciseDetails + String(id)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { return Data() }
    var multipartBody: [Moya.MultipartFormData]? { return [] }
    
}
