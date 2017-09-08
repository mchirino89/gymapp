//
//  Constants.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import Moya

struct Constants {
    
    enum kindOfResult: Int {
        case mainMuscle = 1
        case secondaryMuscles
        case equipment
    }
    
    struct APIConfiguration {
        static let rootURL = "https://wger.de/api/v2"
    }
    
    struct ParameterKey {
        static let contentType = "Content-type"
        static let status = "status"
        static let language = "language"
        static let category = "category"
    }
    
    struct ParameterValue {
        static let contentType = "application/json"
        static let status = 2
        static let language = 2
    }
    
    struct JSONResponseKey {
        static let results = "results"
        
        struct exerciseCategory {
            static let id = "id"
            static let name = "name"
        }
        
        struct exercises {
            static let description = "description"
            static let mainMuscle = "muscles"
            static let secondaryMuscles = "muscles_secondary"
            static let neededEquipment = "equipment"
            static let imageJSON = "medium_cropped"
            static let imageURL = "url"
        }
    }
    
    struct Path {
        static let exerciseGroup = "/exercisecategory"
        static let exerciseList = "/exercise"
        static let exerciseDetails = "/exerciseinfo/"
        static let exerciseImage = "/exerciseimage/"
        static let exerciseImageSize = "/thumbnails"
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
        static let animationDuration = 0.3
        static let exerciseGIF = 2
        static let exerciseGenericTag = "General exercise"
        static let nonApplicable = "N/A"
        static let connector = " and "
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
        static let noImage = "No image data"
        static let noJSONfile = "No JSON file in specified route"
        static let invalidJSON = "Misformatted JSON file"
    }
    
    struct UIMessages {
        static let affirmative = "Yes"
        static let negative = "No"
    }
    
    struct Utilities {
        struct JSON {
            static let fileName = "ExercisesImages"
            static let fileExtension = "json"
        }
    }
    
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

func JSONResponse(kindOfService: Services, completion: @escaping (_ response: AnyObject?) ->()) {
    Singleton.provider.request(kindOfService, completion: { data in
        print(kindOfService.baseURL.absoluteString+kindOfService.path)
        switch data {
        case let .success(moyaResponse):
            do {
                let _ = try moyaResponse.filterSuccessfulStatusCodes()
                do {
                    let JSONdata = try moyaResponse.mapJSON()
                    completion(JSONdata as AnyObject)
                    print("\(kindOfService.path) loaded")
                } catch {
                    print("Something went wrong mapping \(kindOfService.path) JSON request")
                    print(data.debugDescription)
                    print("Error code: ", moyaResponse.statusCode)
                }
            } catch {
                print("Something went wrong on \(kindOfService.path) request, code: ", data.value!.statusCode)
            }
        case let .failure(error):
            // If failure isn't caused by manual call cancellation
            if error._code != 4 {
                print(error._code)
                print(error)
            }
        }
    })
}
