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
//        print("Component \(component) for picker kind: \(pickerKind)")
        switch pickerKind {
            case Constants.pickerKind.gender.rawValue:
                return Constants.UIElements.genders.count
            case Constants.pickerKind.age.rawValue:
                return Constants.Units.topAge - Constants.Units.minAge
            case Constants.pickerKind.weight.rawValue:
                return Constants.Units.topWeight - Constants.Units.minWeight
            default: // height picker
                return component == 0 ? Constants.Units.topFootHeight - Constants.Units.minFootHeight : 10
        }
    }
    
    // Only height picker will have two components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerKind == Constants.pickerKind.height.rawValue ? 2 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        print("Component: \(component): \(row)")
        switch pickerKind {
            case Constants.pickerKind.gender.rawValue:
                var genderLabel = view as! UILabel!
                if genderLabel == nil {
                    genderLabel = UILabel()
                }
                genderLabel?.font = UIFont(name: Constants.UIElements.appFont, size: CGFloat(Constants.UIElements.regularFontSize))
                genderLabel?.textColor = UIColor.white
                genderLabel?.textAlignment = .center
                print(pickerView.numberOfComponents)
                print(pickerView.numberOfRows(inComponent: 0))
                genderLabel?.text = Constants.UIElements.genders[row]
                return genderLabel!
            case Constants.pickerKind.age.rawValue:
                return UIView()
            case Constants.pickerKind.weight.rawValue:
                return UIView()
            default: // height picker
                return UIView()
        }
    }
    
    func pickerViewAnimation(showingPicker: Bool) {
        pickerVerticalLayoutConstraint.constant = showingPicker ? 0 : 1000
        UIView.animate(withDuration: Constants.UIElements.animationDuration, animations: { self.view.layoutIfNeeded() }
        )
    }
    
    func setPlaceholderProfileImage() {
        let row = pickerView.selectedRow(inComponent: 0)
        guard let profileImage = profileImageButton.backgroundImage(for: .normal) else {
            print(Constants.ErrorMessages.noProfilePlaceholder)
            return
        }
        if profileImage == #imageLiteral(resourceName: "Male") || profileImage == #imageLiteral(resourceName: "Female") {
            profileImageButton.setBackgroundImage(UIImage(named: Constants.UIElements.genders[row]), for: .normal)
            nameTextField.placeholder = Constants.UIElements.placeholderNames[row]
        }
    }
}
