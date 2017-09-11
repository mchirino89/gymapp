//
//  ProfileController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

final class ProfileController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var heightButton: UIButton!
    @IBOutlet weak var pickerVerticalLayoutConstraint: NSLayoutConstraint!
    
    let profileImagePicker = UIImagePickerController()
    var pickerKind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationController)
        profileImagePicker.delegate = self
    }
    
    //# Save any changes in the profile in Realm
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func imagePickerAction() {
        profileImagePicker.allowsEditing = false
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: true)
    }

    @IBAction func pickerAction(_ sender: UIButton) {
        pickerKind = sender.tag
        pickerView.reloadAllComponents()
        pickerViewAnimation(showingPicker: true)
    }
    
    @IBAction func okButton() {
        switch pickerKind {
            case Constants.pickerKind.gender.rawValue:
                setPlaceholderProfileImage()
                genderButton.setTitle(Constants.UIElements.genders[pickerView.selectedRow(inComponent: 0)], for: .normal)
                break
            case Constants.pickerKind.age.rawValue:
                ageButton.setTitle(getPickerLabel(row: pickerView.selectedRow(inComponent: 0)), for: .normal)
                break
            case Constants.pickerKind.weight.rawValue:
                weightButton.setTitle(getPickerLabel(row: pickerView.selectedRow(inComponent: 0)), for: .normal)
                break
            default: // height picker
                let shortenHeight = getPickerLabel(row: pickerView.selectedRow(inComponent: 0), component: 0, shorten: true) + getPickerLabel(row: pickerView.selectedRow(inComponent: 1), component: 1, shorten: true)
                heightButton.setTitle(shortenHeight, for: .normal)
                break
        }
        pickerViewAnimation(showingPicker: false)
    }
}
