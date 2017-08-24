//
//  MuscleViewCell.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class MuscleViewCell: UICollectionViewCell {
    @IBOutlet weak var muscleLabel: UILabel!
    
    func setMuscleLabelWithAnimation(_ musclaName: String) {
        muscleLabel.text = musclaName
        self.muscleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.9, animations: {
            self.muscleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
}
