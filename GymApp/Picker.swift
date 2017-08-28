//
//  Picker.swift
//  GymApp
//
//  Created by Mauricio Chirino on 27/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ProfileController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.UIElements.genders.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let profileImage = profileImageButton.backgroundImage(for: .normal) else {
            print(Constants.ErrorMessages.noProfilePlaceholder)
            return
        }
        if profileImage == #imageLiteral(resourceName: "Male") || profileImage == #imageLiteral(resourceName: "Female") {
            profileImageButton.setBackgroundImage(UIImage(named: Constants.UIElements.genders[row]), for: .normal)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var genderLabel = view as! UILabel!
        if genderLabel == nil {
            genderLabel = UILabel()
        }
        genderLabel?.font = UIFont(name: Constants.UIElements.appFont, size: CGFloat(Constants.UIElements.regularFontSize))
        genderLabel?.textColor = UIColor.white
        genderLabel?.textAlignment = .center
        genderLabel?.text = Constants.UIElements.genders[row]
        return genderLabel!
    }
}
