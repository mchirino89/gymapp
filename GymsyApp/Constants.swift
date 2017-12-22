//
//  Constants.swift
//  GymsyApp
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
    
    enum pickerKind: Int {
        case gender = 1
        case age
        case weight
        case height
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
        static let genderPlaceholder = "Your gender"
        static let agePlaceholder = "Your age"
        static let weightPlaceholder = "Your weight"
        static let heightPlaceholder = "Your height"
        static let reloadButton = "Refresh"
    }
    
    struct Units {
        static let topAge = 100
        static let minAge = 18
        static let topWeight = 301
        static let minWeight = 90
        static let topFootHeight = 10
        static let minFootHeight = 3
        static let age = " years"
        static let weight = " pounds"
        static let height = " feet"
        static let inch = " inches"
        static let heightSh = " ft "
        static let inchSh = " in"
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
        static let invalidUserInfo = "Unable to retrieved previously stored user data"
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
//        print(kindOfService.baseURL.absoluteString + kindOfService.path)
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
                    failureInConnectionAlert(invalidCompletion: completion)
                }
            } catch {
                print("Something went wrong on \(kindOfService.path) request, code: ", data.value!.statusCode)
                failureInConnectionAlert(invalidCompletion: completion)
            }
        case let .failure(error):
            print(error.localizedDescription)
            failureInConnectionAlert(invalidCompletion: completion)
        }
    })
}

func JSONResponseData(kindOfService: Services, completion: @escaping (_ response: Data?) ->()) {
    Singleton.provider.request(kindOfService, completion: { data in
        //        print(kindOfService.baseURL.absoluteString + kindOfService.path)
        switch data {
        case let .success(moyaResponse):
            do {
                let _ = try moyaResponse.filterSuccessfulStatusCodes()
                do {
                    let JSONdata = try moyaResponse.mapString().data(using: .utf8)
                    completion(JSONdata)
                    print("\(kindOfService.path) loaded")
                } catch {
                    print("Something went wrong mapping \(kindOfService.path) JSON request")
                    print(data.debugDescription)
                    print("Error code: ", moyaResponse.statusCode)
                    failureInConnectionAlert(invalidCompletion: completion)
                }
            } catch {
                print("Something went wrong on \(kindOfService.path) request, code: ", data.value!.statusCode)
                failureInConnectionAlert(invalidCompletion: completion)
            }
        case let .failure(error):
            print(error.localizedDescription)
            failureInConnectionAlert(invalidCompletion: completion)
        }
    })
}

func showLoadingButton() {
    
}

private func failureInConnectionAlert(invalidCompletion: ((AnyObject?) -> Void)) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        invalidCompletion(nil)
        topController.present(getPopupAlert(message: Constants.ErrorMessages.internetConnection), animated: true)
    } else {
        print("Impossible to access current view controller")
    }
}

private func failureInConnectionAlert(invalidCompletion: ((Data?) -> Void)) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        invalidCompletion(nil)
        topController.present(getPopupAlert(message: Constants.ErrorMessages.internetConnection), animated: true)
    } else {
        print("Impossible to access current view controller")
    }
}
