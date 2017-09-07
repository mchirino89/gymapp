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
        layout.itemSize = CGSize(width: (view.bounds.width / 2) - 2, height: view.bounds.height / 4.75)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        listCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muscleGroupDataSource?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Storyboard.cellId, for: indexPath) as! ListViewCell
        // Cell can refer either to a muscle group (abs, arms, legs, etc) or a specific exercise for a previous selected muscle group/routine (squat, push press, crunches, etc)
        cell.setDetailLabelWithAnimation(muscleGroupDataSource!.result![indexPath.row].name!, [muscleGroupDataSource!.result![indexPath.row].id!])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListViewCell
        performSegue(withIdentifier: muscleGroupList ? Constants.Storyboard.exerciseListSegue : Constants.Storyboard.exerciseDetailSegue, sender: [cell.referenceIds.first as Any, cell.detailLabel.text as Any])
    }
}
