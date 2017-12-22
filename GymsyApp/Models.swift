//
//  Lists.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 22/12/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Foundation

struct Result: Codable {
    let id: Int
    let name: String
}

struct Listing: Codable {
    let results: [Result]?
}

struct ExerciseDetail: Codable {
    let category: Result?
    let mainMuscles: [Result]?
    let secondaryMuscles: [Result]?
    let equipment: [Result]?
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case category
        case equipment
        case description
        case mainMuscles = "muscles"
        case secondaryMuscles = "muscles_secondary"
    }
//    description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
}

