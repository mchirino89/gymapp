//
//  Definitions.swift
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
