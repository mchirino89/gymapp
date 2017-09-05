//
//  TextArea.swift
//  GymApp
//
//  Created by Mauricio Chirino on 5/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension DetailController: UITextViewDelegate {

    // Used for fading out floating config button
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.15, animations: {
            self.configExerciseButton.alpha = 0.25
        }, completion: { _ in
            self.configExerciseButton.isEnabled = false
        })
    }
    
    // Used for fading in floating config button
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.15, animations: {
            self.configExerciseButton.alpha = 1
        }, completion: { _ in
            self.configExerciseButton.isEnabled = true
        })
    }
    
}
