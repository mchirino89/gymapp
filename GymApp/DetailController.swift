//
//  DetailController.swift
//  GymApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper
import Moya

final class DetailController: UIViewController {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionTextView: UITextView!
    @IBOutlet weak var configExerciseButton: ButtonStyle!
    @IBOutlet weak var loadingVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var mainMuscleLabel: UILabel!
    @IBOutlet weak var secondaryMusclesLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadAgainButton: UIButton!
    
    var exerciseId:Int = 0
    var exerciseName:String = ""
    var exerciseInfo:ExerciseDetails?
    var exerciseImageDictionary:ResultList?
    var exerciseImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.DetailView.title
        exerciseNameLabel.text = exerciseName
        readJSONlist()
        loadDetails()
    }
    
    @IBAction func loadAgainAction() {
        loadDetails()
    }
    
    private func loadDetails() {
        viewLoader(true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let view = self else { return }
            JSONResponse(kindOfService: .exerciseDetails(id: view.exerciseId), completion: { (JSONdata) in
                guard let parsedData = JSONdata else {
                    // make visible "load again" button
                    view.loadAgainButton.isHidden = false
                    view.viewLoader(false)
                    return
                }
                view.exerciseInfo <-- parsedData
                DispatchQueue.main.async {
                    view.categoryLabel.text? += view.exerciseInfo!.category!.name!
                    view.exerciseDescriptionTextView.text = view.exerciseInfo?.description
                    view.mainMuscleLabel.text? += view.makeListSentence(list: view.exerciseInfo?.muscles?.result)
                    view.secondaryMusclesLabel.text? += view.makeListSentence(list: view.exerciseInfo?.secondaryMuscles?.result)
                    view.equipmentLabel.text? += view.makeListSentence(list: view.exerciseInfo?.equipment?.result)
                    view.viewLoader(false)
                }
            })
        }
    }
    
    private func makeListSentence(list: [ResultDetails]?) -> String {
        guard let response = list else { return "" }
        switch response.count {
        case 0:
            return Constants.UIElements.nonApplicable
        case 1:
            return response.first!.name!
        case 2:
            return response.first!.name! + Constants.UIElements.connector + response.last!.name!
        default:
            var currentIndex = 0
            var sentence = ""
            let _ = response.map { word in
                if currentIndex + 1 == response.count {
                    return
                }
                currentIndex += 1
                sentence.append(word.name! + ", ")
            }
            return sentence + Constants.UIElements.connector + response.last!.name!
        }
    }
    
    private func readJSONlist() {
        do {
            if let file = Bundle.main.url(forResource: Constants.Utilities.JSON.fileName, withExtension: Constants.Utilities.JSON.fileExtension) {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    exerciseImageDictionary <-- object
                    let imagesForExercise = exerciseImageDictionary?.result?
                        .filter({ $0.id == exerciseId })
                        .map {
                            setExerciseImage(sourceURL: $0.name!)
                    }
                    if imagesForExercise!.isEmpty {
                        exerciseImageView.image = #imageLiteral(resourceName: "dumbbell")
                        imageActivityIndicator.stopAnimating()
                    }
                } else {
                    print(Constants.ErrorMessages.invalidJSON)
                }
            } else {
                print(Constants.ErrorMessages.noJSONfile)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setExerciseImage(sourceURL: String) {
        guard let storedImage = Singleton.imageCache.object(forKey: sourceURL as NSString) else {
            let imageRequest = Singleton.provider.manager.request(URL(string: sourceURL)!)
            imageRequest.responseData(completionHandler: { [weak self] (requestData) in
                guard let view = self else { return }
                guard let imageData = requestData.data else {
                    print(Constants.ErrorMessages.noImage)
                    return
                }
                view.exerciseImages.append(UIImage(data: imageData)!)
                view.exerciseImageView.backgroundColor = UIColor.white
                Singleton.imageCache.setObject(imageData as NSData, forKey: sourceURL as NSString)
                view.generateExerciseGIF(Constants.UIElements.exerciseGIF)
            }).resume()
            return
        }
        exerciseImages.append(UIImage(data: storedImage as Data)!)
        generateExerciseGIF(Constants.UIElements.exerciseGIF)
    }
    
    // Hides/Shows vissual effect + activity indicator view
    private func viewLoader(_ isVisible: Bool) {
        loadingVisualEffectView.isHidden = !isVisible
    }
    
    func generateExerciseGIF(_ delayInSeconds : Int) {
        if delayInSeconds > 0 && exerciseImages.count > 1 {
            imageActivityIndicator.stopAnimating()
            exerciseImageView.image = exerciseImageView.image == exerciseImages.first! ? exerciseImages.last! : exerciseImages.first!
            let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
                guard let view = self else { return }
                view.generateExerciseGIF(delayInSeconds)
            }
        } else if exerciseImages.count == 1 {
            exerciseImageView.image = exerciseImages.first!
        }
        imageActivityIndicator.stopAnimating()
    }
}
