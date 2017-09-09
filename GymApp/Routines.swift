//
//  Routines.swift
//  GymApp
//
//  Created by Mauricio Chirino on 8/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

struct Routines {
    let names = ["Top Strength", "Core Strength", "Iron Arms", "Leg Day", "Superhero back", ]
    let images = [#imageLiteral(resourceName: "chest"), #imageLiteral(resourceName: "abs"), #imageLiteral(resourceName: "arms"), #imageLiteral(resourceName: "legs"), #imageLiteral(resourceName: "back")]
    
    struct exercise {
        var id:Int = 0
        var name:String = ""
    }
    
    struct levels {
        var id:Int = 0
        var exercises:[exercise] = []
        
        init(id: Int) {
            self.id = id
        }
    }
    
    var custom:[levels] = []
    
    init() {
        custom.append(levels(id: 1))
        custom[0].exercises.append(exercise(id: 192, name: "Bench press"))
        custom[0].exercises.append(exercise(id: 207, name: "Cable cross over"))
        custom[0].exercises.append(exercise(id: 122, name: "Fly with cable"))
        custom[0].exercises.append(exercise(id: 412, name: "Bent over barbell row"))
        custom[0].exercises.append(exercise(id: 105, name: "Deadlifts"))
        custom[0].exercises.append(exercise(id: 181, name: "Chin-ups"))
        custom[0].exercises.append(exercise(id: 216, name: "Straight-arm pull down"))
        custom[0].exercises.append(exercise(id: 124, name: "Butterfly reverse"))
        custom[0].exercises.append(exercise(id: 394, name: "Facepull"))
    }
}
