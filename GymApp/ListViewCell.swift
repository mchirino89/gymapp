//
//  ListViewCell.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

final class ListViewCell: UICollectionViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    var referenceIds:Int = 0
    func setDetailLabelWithAnimation(_ musclaName: String, _ referenceIds: Int) {
        self.referenceIds = referenceIds
        detailLabel.text = musclaName
        detailLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.9, animations: {
            self.detailLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
}
