//
//  MuscleController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var kindOfList = 0
    var dataId:Int?
    let muscleLabel = ["Abs", "Arms", "Back", "Calves", "Chest", "Legs", "Shoulders"]
    let exerciseLabel = ["Axe Hold", "Barbell Triceps Extension", "Bench Press Narrow Grip", "Biceps Curls With Barbell", "Biceps Curls With Dumbbell", "Biceps Curls With SZ-bar", "Biceps Curl With Cable", "Body-Ups", "Close-grip Bench Press", "Deadhang", "Dips", "Dips Between Two Benches", "Dumbbell Concentration Curl", "Dumbbell Incline Curl", "Dumbbells on Scott Machine", "Dumbbell Triceps Extension", "French Press (skullcrusher) Dumbbells", "French Press (skullcrusher) SZ-bar", "Hammercurls", "Hammercurls on Cable"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = kindOfList == 0 ? Constants.MuscleView.title : Constants.ExerciseView.title
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From muscles to exercises per muscle
        if segue.destination.isKind(of: ListController.self) {
            guard let destination = segue.destination as? ListController else { return }
            destination.kindOfList = 1
            destination.dataId = sender as? Int
        } else { // From exercises per muscle to exercise details
            
        }
    }
    
}

extension ListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    func setCollectionLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.bounds.width / 2) - 5, height: view.bounds.height / 4.8)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        listCollectionView.collectionViewLayout = layout
    }
}
