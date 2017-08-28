//
//  ProfileController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    @IBOutlet var genderPickerView: UIPickerView!
    @IBOutlet weak var genderVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    let profileImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageButton.layer.cornerRadius = view.frame.width / 2
        setNavigationBar(navigationController)
        profileImagePicker.delegate = self
    }
    
    @IBAction func imagePickerAction() {
        profileImagePicker.allowsEditing = false
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: true)
    }

    @IBAction func pickGenderAction() {
        view.bringSubview(toFront: genderVisualEffectView)
        UIView.animate(withDuration: 0.35, animations: {
            self.genderVisualEffectView.alpha = 1
        })
    }
    
    @IBAction func okButton() {
        genderButton.setTitle(Constants.UIElements.genders[genderPickerView.selectedRow(inComponent: 0)], for: .normal)
        UIView.animate(withDuration: 0.35, animations: {
            self.genderVisualEffectView.alpha = 0
        }, completion: { _ in
            self.view.sendSubview(toBack: self.genderVisualEffectView)
        })
    }
    
    @IBAction func nameAction() {
    }
}
