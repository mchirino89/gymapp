//
//  ProfileImage.swift
//  GymApp
//
//  Created by Mauricio Chirino on 27/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // I took the whatsapp approach for this: reducing image quality locally and showing the final result to the user instantly so he sees it and change it in case he's not happy about it.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageButton.setImage(UIImage(data: UIImageJPEGRepresentation(pickedImage, 0.45)!), for: .normal)
            profileImageButton.setBackgroundImage(nil, for: .normal)
        } else {
            print(Constants.ErrorMessages.wrongImageFormat)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
