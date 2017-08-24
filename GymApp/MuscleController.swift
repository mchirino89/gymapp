//
//  MuscleController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class MuscleController: UIViewController {
    @IBOutlet weak var muscleCollectionView: UICollectionView!
    
    let muscleLabel = ["Abs", "Arms", "Back", "Calves", "Chest", "Legs", "Shoulders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionLayout()
        setNavigationBar(navigationController)
    }
    
}

extension MuscleController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muscleLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MuscleView.muscleCellId, for: indexPath) as! MuscleViewCell
        cell.setMuscleLabelWithAnimation(muscleLabel[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MuscleViewCell
        UIView.animate(withDuration: 0.3, animations: {
            cell.muscleLabel.frame.size.height = cell.bounds.height * 1.25
            cell.muscleLabel.frame.size.width = cell.bounds.width * 1.25
        })
    }
    
    func setCollectionLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 2, height: view.bounds.width / 3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        muscleCollectionView.collectionViewLayout = layout
    }
}
