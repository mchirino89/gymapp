//
//  ExerciseController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper

class ExerciseController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var exerciseListActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var exerciseTagLabel: UILabel?
    
    var muscleGroupList = true
    var dataId:[Int] = []
    var viewTitle:String?
    var muscleGroupDataSource:ExerciseGroupList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = muscleGroupList ? Constants.MuscleView.title : Constants.ExerciseView.title
        exerciseTagLabel?.text = "For: \(viewTitle ?? Constants.UIElements.exerciseGenericTag)"
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        loadList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From muscles to exercises per muscle
        if segue.destination.isKind(of: ExerciseController.self) {
            guard let destination = segue.destination as? ExerciseController, let sentParameters = sender as? [Any] else { return }
            destination.muscleGroupList = false
            destination.dataId.append((sentParameters.first as? Int) ?? 0)
            destination.viewTitle = sentParameters.last as? String
        } else { // From exercises per muscle to exercise details
            guard let destination = segue.destination as? DetailController else { return }
            destination.exerciseId = (sender as? Int) ?? 0
        }
    }
    
    private func loadList() {
        exerciseListActivityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] _ in
            let _ = JSONResponse(kindOfService: self.muscleGroupList ? .muscleGroup : .exerciseGroup(id: self.dataId.first!), completion: { (JSONdata) in
                self.muscleGroupDataSource <-- JSONdata
                DispatchQueue.main.async {
                    self.refreshList()
                }
            })
        }
    }
    
    // Refreshes collection view after API response
    private func refreshList() {
        listCollectionView.reloadData()
        exerciseListActivityIndicator.stopAnimating()
    }
}
