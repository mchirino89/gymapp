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
        enableExerciseConfiguration(isEnable: false)
    }
    
    // Used for fading in floating config button
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        enableExerciseConfiguration(isEnable: !scrollView.isDecelerating)
    }
    
    // Used for fading in floating config button
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        enableExerciseConfiguration(isEnable: true)
    }
    
    private func enableExerciseConfiguration(isEnable: Bool) {
        UIView.animate(withDuration: Constants.UIElements.animationDuration, animations: {
            self.configExerciseButton.alpha = isEnable ? 1 : 0.25
        }, completion: { _ in
            self.configExerciseButton.isEnabled = isEnable
        })
    }
    
}
