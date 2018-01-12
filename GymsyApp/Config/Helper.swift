//
//  Helper.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 7/1/18.
//  Copyright © 2018 3CodeGeeks. All rights reserved.
//

import UIKit
import Moya

let customDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

func setNavigationBar(_ navigationController: UINavigationController?) {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
}

func customBackButton(_ navigationItem: UINavigationItem) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

func getPopupAlert(message: String, title: String = Constants.errorMessages.popupTitle, buttonText: String = Constants.errorMessages.popupButton) -> UIAlertController {
    let popupAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    popupAlert.addAction(UIAlertAction(title: buttonText, style: .default))
    return popupAlert
}

func questionPopup(title: String, message: String, style: UIAlertControllerStyle, afirmativeAction: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let questionAlert = UIAlertController(title: title, message: message, preferredStyle: style)
    let logOutAction = UIAlertAction(title: Constants.uiMessages.affirmative, style: .destructive, handler: afirmativeAction)
    questionAlert.addAction(logOutAction)
    questionAlert.addAction(UIAlertAction(title: Constants.uiMessages.negative, style: .default))
    return questionAlert
}

func JSONResponseData(kindOfService: Services, completion: @escaping (_ response: Data?) ->()) {
    Singleton.provider.request(kindOfService, completion: { data in
//        print(kindOfService.baseURL.absoluteString + kindOfService.path)
//        print(kindOfService.task)
        switch data {
        case .success(let moyaResponse):
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

private func failureInConnectionAlert(invalidCompletion: ((Data?) -> Void)) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        invalidCompletion(nil)
        topController.present(getPopupAlert(message: Constants.errorMessages.internetConnection), animated: true)
    } else {
        print("Impossible to access current view controller")
    }
}

private func generateRandomKey() -> String {
    var randomString = ""
    for _ in 1...16  {
        var randomCharacter: Character?
        if let gottenCharacter = UnicodeScalar(alphanumerical(randomChance())) {
            randomCharacter = Character(gottenCharacter)
        } else {
            randomCharacter = Character("-")
        }
        randomString.append(randomChance() ? String(randomCharacter!).uppercased() : String(randomCharacter!).lowercased())
    }
    return randomString
}

private func alphanumerical(_ pairNumber: Bool) -> Int {
    return pairNumber ? Int(arc4random_uniform(Constants.randomKind.alphabetic)) + 65 : Int(arc4random_uniform(Constants.randomKind.numeric)) + 48
}

private func randomChance() -> Bool {
    return arc4random() % 2 == 0
}
