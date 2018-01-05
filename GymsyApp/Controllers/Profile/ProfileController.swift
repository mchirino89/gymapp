//
//  ProfileController.swift
//  GymsyApp
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
        let userProfile = Singleton.dataSource.objects(Profile.self)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction)))
        if !userProfile.isEmpty {
            guard let userInfo = userProfile.first else {
                print(Constants.ErrorMessages.invalidUserInfo)
                return
            }
            nameTextField.text = userInfo.name
            if let profileImage = userInfo.image {
                profileImageButton.setImage(UIImage(data: profileImage), for: .normal)
            }
            if let gender = userInfo.gender {
                genderButton.setTitle(gender, for: .normal)
            }
            if let age = userInfo.age {
                ageButton.setTitle(age, for: .normal)
            }
            if let weight = userInfo.weight {
                weightButton.setTitle(weight, for: .normal)
            }
            if let height = userInfo.height {
                heightButton.setTitle(height, for: .normal)
            }
        }
    }
    
    //# Save any changes in the profile in Realm
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let updateProfile = Profile()
        let profileImage = profileImageButton.currentBackgroundImage
        updateProfile.name = nameTextField.text
        if profileImage != #imageLiteral(resourceName: "Male") && profileImage != #imageLiteral(resourceName: "Female") {
            updateProfile.image = UIImageJPEGRepresentation(profileImageButton.currentImage!, 1)
        }
        if genderButton.currentTitle != Constants.UIElements.genderPlaceholder {
            updateProfile.gender = genderButton.currentTitle
        }
        if ageButton.currentTitle != Constants.UIElements.agePlaceholder {
            updateProfile.age = ageButton.currentTitle
        }
        if weightButton.currentTitle != Constants.UIElements.weightPlaceholder {
            updateProfile.weight = weightButton.currentTitle
        }
        if heightButton.currentTitle != Constants.UIElements.heightPlaceholder {
            updateProfile.height = heightButton.currentTitle
        }
        do {
            try Singleton.dataSource.write {
                Singleton.dataSource.add(updateProfile, update: true)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @objc func dismissKeyboardAction() {
        view.endEditing(true)
    }
    
    @IBAction func imagePickerAction() {
        profileImagePicker.allowsEditing = false
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: true)
    }

    @IBAction func pickerAction(_ sender: UIButton) {
        dismissKeyboardAction()
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
