//
//  Constants.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

struct Constants {
    
    struct APIConfiguration {
        static let rootURL = "https://wger.de/api/v2"
    }
    
    struct ParameterKey {
        static let contentType = "Content-type"
    }
    
    struct ParameterValue {
        static let contentType = "application/json"
    }
    
    struct JSONResponseKey {}
    
    struct Path {
        static let exerciseGroup = "/exercisecategory"
    }
    
    struct Storyboard {
        static let cellId = "detailCell"
        static let exerciseListSegue = "muscleDetailsSegue"
        static let exerciseDetailSegue = "specificDetailSegue"
        static let routineDetailSegue = "routinesDetailesSegue"
        static let routineCell = "routineCell"
    }
    
    struct UIElements {
        static let title = "Gym App"
        static let genders = ["Male", "Female"]
        static let placeholderNames = ["John Doe", "Jane Doe"]
        static let appFont = "Copperplate"
        static let regularFontSize = 25
        static let animationDuration = 0.25
    }
    
    struct ErrorMessages {
        static let internetConnection = "It seems you don't have an active internet connection right now. Make sure you do before you try again please"
        static let parsingJSON = "Could not parse the data as JSON: "
        static let noData = "No data was returned by the request!"
        static let generic = "There was an error with your request: "
        static let popupTitle = "Oops!"
        static let popupButton = "Ok"
        static let wrongImageFormat = "There was an error retrieving the selected image from the Library"
        static let noProfilePlaceholder = "There aren't any profile images placeholders"
        static let tabItemError = "Unable to access first item in tab"
    }
    
    struct UIMessages {
        static let affirmative = "Yes"
        static let negative = "No"
    }
    
    struct Utilities {}
    
    struct MuscleView {
        static let title = "Muscles"
    }
    
    struct ExerciseView {
        static let title = "Exercises"
    }
    
    struct DetailView {
        static let title = "Details"
    }
    
    struct RegularExpressions {
        static let age = "[0-9]+"
    }
}

func setNavigationBar(_ navigationController: UINavigationController?) {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
}

func customBackButton(_ navigationItem: UINavigationItem) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

func getPopupAlert(message: String, title: String = Constants.ErrorMessages.popupTitle, buttonText: String = Constants.ErrorMessages.popupButton) -> UIAlertController {
    let popupAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    popupAlert.addAction(UIAlertAction(title: buttonText, style: .default))
    return popupAlert
}

func questionPopup(title: String, message: String, style: UIAlertControllerStyle, afirmativeAction: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let questionAlert = UIAlertController(title: title, message: message, preferredStyle: style)
    let logOutAction = UIAlertAction(title: Constants.UIMessages.affirmative, style: .destructive, handler: afirmativeAction)
    questionAlert.addAction(logOutAction)
    questionAlert.addAction(UIAlertAction(title: Constants.UIMessages.negative, style: .default))
    return questionAlert
}
