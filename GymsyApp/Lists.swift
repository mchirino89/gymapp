//
//  Lists.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 22/12/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import Foundation

struct Listing: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let id: Int
    let name: String
}
