//
//  Constants.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

struct Constants {
    
    struct APIConfiguration {}
    
    struct ParameterKey {}
    
    struct ParameterValue {}
    
    struct JSONResponseKey {}
    
    struct URL {}
    
    struct Storyboard {
        static let locationSegue = "locationSegue"
        static let photoCell = "photoCell"
        static let fullScreenSegue = "fullImageSegue"
    }
    
    struct UIElements {
        static let title = "Gym App"
        static let customTitleFont = "MarkerFelt-Thin"
    }
    
    struct ErrorMessages {
        static let internetConnection = "It seems you don't have an active internet connection right now. Make sure you do before you try again please"
        static let parsingJSON = "Could not parse the data as JSON: "
        static let noData = "No data was returned by the request!"
        static let generic = "There was an error with your request: "
        static let popupTitle = "Oops!"
        static let popupButton = "Ok"
    }
    
    struct UIMessages {
        static let affirmative = "Yes"
        static let negative = "No"
    }
    
    struct Utilities {}
    
    struct MuscleView {
        static let muscleCellId = "muscleCell"
        static let title = "Muscles"
    }
    
}

func setNavigationBar(_ navigationController: UINavigationController?) {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
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
