//
//  TextField.swift
//  GymApp
//
//  Created by Mauricio Chirino on 11/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ProfileController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboardAction()
        return false
    }
}
