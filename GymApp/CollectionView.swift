//
//  CollectionView.swift
//  GymApp
//
//  Created by Mauricio Chirino on 4/9/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

extension ExerciseController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setCollectionLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.bounds.width / 2) - 5, height: view.bounds.height / 4.75)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        listCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kindOfList == 0 ? muscleLabel.count : exerciseLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Storyboard.cellId, for: indexPath) as! ListViewCell
        cell.setDetailLabelWithAnimation(kindOfList == 0 ? muscleLabel[indexPath.row] : exerciseLabel[indexPath.row], indexPath.row|indexPath.section)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListViewCell
        performSegue(withIdentifier: kindOfList == 0 ? Constants.Storyboard.exerciseListSegue : Constants.Storyboard.exerciseDetailSegue, sender: cell.idForCell)
    }
}
