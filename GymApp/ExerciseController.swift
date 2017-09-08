//
//  ExerciseController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper
import Moya

class ExerciseController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var exerciseListActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var exerciseTagLabel: UILabel?
    
    var muscleGroupList = true
    var dataId:[Int] = []
    var viewTitle:String?
    var muscleGroupDataSource:ExerciseGroupList?
    var APICall:Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        loadList()
        guard let exerciseTag = exerciseTagLabel else { return }
        exerciseTag.text = "For: \(viewTitle ?? Constants.UIElements.exerciseGenericTag)"
        title = Constants.ExerciseView.title
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
    
    //
    private func loadList() {
        exerciseListActivityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async { [weak self] _ in
            guard let view = self else { return }
            view.APICall = JSONResponse(kindOfService: view.muscleGroupList ? .muscleGroup : .exerciseGroup(id: view.dataId.first!), completion: { (JSONdata) in
                view.muscleGroupDataSource <-- JSONdata
                DispatchQueue.main.async {
                    view.refreshList()
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
