//
//  ProfileController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet var genderPickerView: UIPickerView!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    let profileImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageButton.layer.cornerRadius = view.frame.width * 0.325
        setNavigationBar(navigationController)
        profileImagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction)))
    }
    
    //# Save any changes in the info in the local storage
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //# Keyboard events and handling
    
    func keyboardWillShow(_ notification:Notification) {
        if view.frame.origin.y >= 0 && !nameTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if view.frame.origin.y < 0  {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func dismissKeyboardAction() {
        view.endEditing(true)
    }
    
    @IBAction func imagePickerAction() {
        profileImagePicker.allowsEditing = false
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: true)
    }

    @IBAction func pickGenderAction() {
        dismissKeyboardAction()
        view.bringSubview(toFront: genderVisualEffectView)
        UIView.animate(withDuration: Constants.UIElements.animationDuration, animations: {
            self.genderVisualEffectView.alpha = 1
        })
    }
    
    @IBAction func okButton() {
        genderButton.setTitle(Constants.UIElements.genders[genderPickerView.selectedRow(inComponent: 0)], for: .normal)
        UIView.animate(withDuration: Constants.UIElements.animationDuration, animations: {
            self.genderVisualEffectView.alpha = 0
        }, completion: { _ in
            self.view.sendSubview(toBack: self.genderVisualEffectView)
        })
    }
}
