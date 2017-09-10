//
//  Settings.swift
//  GymApp
//
//  Created by Mauricio Chirino on 9/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import RealmSwift

func preFillRealm() {
    do {
//        removeRealm()
        Singleton.dataSource = try Realm()
        print("Allocating memory for realm file")
        let exercisesForRoutine = [
            ["Bench press", "Cable cross over", "Fly with cable", "Side to side push up", "Bent over barbell row", "Deadlifts", "Chin-ups", "Straight-arm pull down", "Butterfly reverse", "Facepull"],
            ["Hip raise, lying", "Prone scapular retraction - Arms at side", "Side dumbbell trunk flexion", "V-Bar Pulldown", "Rowing T-Bar", "Barbell ab rollout", "Hollow hold", "L hold", "Plank", "Splinter sit-ups"],
            ["Arnold shoulder press", "Bent-over lateral raises", "Front raises", "Rever bar curl", "Seated triceps press", "Tricep dumbbell kickback", "Triceps bench press one barbell", "Barbell tricep extension", "Biceps curl with barbell", "Hammercurls"],
            ["Flutter kicks", "Crunches with legs up", "Hanging leg raises", "Roman chair", "Glute bridge", "Barbell lunges", "Bulgarian split squat", "Front squat", "Leg curls", "Leg extension"],
            ["Deficit deadlif", "Superman", "Underhand lat pull down", "Pull-ups", "Rowing, lying on bench", "Shrugs, barbell", "Side raise", "Upright row on multi press", "Snach", "Rear delt raises"]
        ]
        let idForRoutine = [
            [192, 207, 122, 302, 412, 105, 181, 216, 124, 394],
            [376, 429, 278, 424, 106, 343, 383, 281, 238, 170],
            [227, 421, 233, 208, 386, 279, 186, 344, 74, 86],
            [303, 416, 166, 263, 408, 405, 346, 191, 154, 177],
            [381, 330, 212, 107, 142, 150, 319, 147, 271, 237]
        ]
        if Singleton.dataSource.isEmpty {
            let customRoutines = [
                Routine(id: 1, name: "Top Strength", imageName: "chest"),
                Routine(id: 2, name: "Core Strength", imageName: "abs"),
                Routine(id: 3, name: "Iron Arms", imageName: "arms"),
                Routine(id: 4, name: "Krato's legs", imageName: "legs"),
                Routine(id: 5, name: "Superhero back", imageName: "back")
            ]
            for (i, routine) in customRoutines.enumerated() {
                for (j, exerciseId) in idForRoutine[i].enumerated() {
                    let newExercise = Exercise(id: exerciseId, name: exercisesForRoutine[i][j])
                    newExercise.belongsTo = routine
                    routine.exercises.append(newExercise)
                }
            }
            do {
                try Singleton.dataSource.write {
                    customRoutines.forEach { routine in
                        Singleton.dataSource.add(routine)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            print("Using preexisting realm database")
        }
    } catch let error as NSError {
        print(error)
    }
}

func removeRealm() {
    let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
    let realmURLs = [
        realmURL,
        realmURL.appendingPathExtension("lock"),
        realmURL.appendingPathExtension("note"),
        realmURL.appendingPathExtension("management")
    ]
    for URL in realmURLs {
        do {
            try FileManager.default.removeItem(at: URL)
        } catch let error as NSError {
            print(error)
        }
    }
    print("Removed realm from device")
}
