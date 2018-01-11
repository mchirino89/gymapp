//
//  Picker.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 27/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ProfileController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        print("Component \(component) for picker kind: \(pickerKind)")
        switch pickerKind {
            case .gender:
                return Constants.uiElements.genders.count
            case .age:
                return Constants.units.topAge - Constants.units.minAge
            case .weight:
                return Constants.units.topWeight - Constants.units.minWeight
            default: // height picker
                return component == 0 ? Constants.units.topFootHeight - Constants.units.minFootHeight : 10
        }
    }
    
    // Only height picker will have two components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerKind == .height ? 2 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if pickerLabel == nil {
            pickerLabel = UILabel()
        }
        pickerLabel?.font = UIFont(name: Constants.uiElements.appFont, size: Constants.uiElements.regularFontSize)
        pickerLabel?.textColor = UIColor.white
        pickerLabel?.textAlignment = .center
        switch pickerKind {
            case .gender:
                pickerLabel?.text = Constants.uiElements.genders[row]
                break
            case .age, .weight:
                pickerLabel?.text = getPickerLabel(row: row)
                break
            default: // height picker
                pickerLabel?.text = getPickerLabel(row: row, component: component)
        }
        return pickerLabel!
    }
    
    func pickerViewAnimation(showingPicker: Bool) {
        pickerVerticalLayoutConstraint.constant = showingPicker ? 0 : 1000
        UIView.animate(withDuration: Constants.uiElements.animationDuration, animations: { self.view.layoutIfNeeded() }
        )
    }
    
    func setPlaceholderProfileImage() {
        let row = pickerView.selectedRow(inComponent: 0)
        guard let profileImage = profileImageButton.backgroundImage(for: .normal) else {
            print(Constants.errorMessages.noProfilePlaceholder)
            return
        }
        if profileImage == #imageLiteral(resourceName: "Male") || profileImage == #imageLiteral(resourceName: "Female") {
            profileImageButton.setBackgroundImage(UIImage(named: Constants.uiElements.genders[row]), for: .normal)
            nameTextField.placeholder = Constants.uiElements.placeholderNames[row]
        }
    }
    
    func getPickerLabel(row: Int, component: Int = 0, shorten: Bool = false) -> String {
        switch pickerKind {
            case .age:
                return String(Constants.units.minAge + row) + Constants.units.age
            case .weight:
                return String(Constants.units.minWeight + row) + Constants.units.weight
            default: // height picker
                if shorten == false {
                    return component == 0 ? String(Constants.units.minFootHeight + row) + Constants.units.height : String(row + 1) + Constants.units.inch
                }
                return component == 0 ? String(Constants.units.minFootHeight + row) + Constants.units.heightSh : String(row + 1) + Constants.units.inchSh
        }
    }
}
