//
//  ExerciseController.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 23/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper

final class ExerciseController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var refreshListVisualEffect: UIVisualEffectView!
    @IBOutlet weak var exerciseTagLabel: UILabel?
    @IBOutlet weak var loadAgainButton: UIButton!
    
    var muscleGroupList = 0
    var dataId:Int = 0
    var viewTitle:String?
    var itemsDataSource:ResultList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionLayout()
        setNavigationBar(navigationController)
        customBackButton(navigationItem)
        muscleGroupList < 2 ? loadList() : viewLoader(false)
        guard let exerciseTag = exerciseTagLabel else { return }
        exerciseTag.text = "For: \(viewTitle ?? Constants.UIElements.exerciseGenericTag)"
        title = Constants.ExerciseView.title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From muscles to exercises per muscle
        if segue.destination.isKind(of: ExerciseController.self) {
            guard let destination = segue.destination as? ExerciseController, let sentParameters = sender as? [Any] else { return }
            destination.muscleGroupList = 1
            destination.dataId = sentParameters.first as? Int ?? 0
            destination.viewTitle = sentParameters.last as? String
        } else { // From exercises per muscle to exercise details
            guard let destination = segue.destination as? DetailController, let sentParameters = sender as? [Any] else { return }
            destination.exerciseId = (sentParameters.first as? Int) ?? 0
            destination.exerciseName = (sentParameters.last as? String) ?? Constants.UIElements.exerciseGenericTag
        }
    }
    
    @IBAction func loadAgainAction() {
        loadList()
    }
    
    // Deppending on which view this is called, the right endpoint for retrieving data will be called
    private func loadList() {
        loadAgainButton.isHidden = true
        viewLoader(true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] _ in
            guard let view = self else { return }
            JSONResponse(kindOfService: view.muscleGroupList == 0 ? .muscleGroup : .exerciseGroup(id: view.dataId), completion: { (JSONdata) in
                guard let parsedData = JSONdata else {
                    // make visible "load again" button
                    view.loadAgainButton.isHidden = false
                    view.viewLoader(false)
                    return
                }
                view.itemsDataSource <-- parsedData
                DispatchQueue.main.async {
                    view.refreshList()
                }
            })
        }
    }
    
    // Refreshes collection view after API response
    private func refreshList() {
        listCollectionView.reloadData()
        viewLoader(false)
    }
    
    // Hides/Shows vissual effect + activity indicator view
    private func viewLoader(_ isVisible: Bool) {
        refreshListVisualEffect.isHidden = !isVisible
    }
}
