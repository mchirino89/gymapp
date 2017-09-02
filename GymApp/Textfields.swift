//
//  Textfields.swift
//  GymApp
//
//  Created by Mauricio Chirino on 27/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ProfileController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == ageTextField {
//            do {
//                let regex = try NSRegularExpression(pattern: Constants.RegularExpressions.age, options: [])
//                
//                let results = regex.matches(in: textField.text!, options: .withoutAnchoringBounds, range: NSRange(location: 0, length: textField.text!.characters.count))
//                
//                print(results)
//                
//            } catch let error as NSError {
//                print("invalid regex: \(error.localizedDescription)")
//                return false
//            }
//        }
        return true
    }
}
