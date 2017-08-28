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
        return true
    }
}
