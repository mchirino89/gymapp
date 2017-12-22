//
//  DetailController.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 24/8/17.
//  Copyright © 2017 3CodeGeeks. All rights reserved.
//

import UIKit
import JSONHelper
import Moya
import Alamofire

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
    
    var exerciseId:Int = 0
    var exerciseName:String = ""
    var exerciseInfo:ExerciseDetail?
    var exerciseImageDictionary:ResultList?
    var exerciseImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.DetailView.title
        exerciseNameLabel.text = exerciseName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(rightButtonAction(sender:)))
        readJSONlist()
        loadDetails()
    }
    
    func rightButtonAction(sender: UIBarButtonItem) {
        loadDetails()
    }
    
    private func loadDetails() {
        reloadButton(isShowing: false)
        viewLoader(true)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let view = self else { return }
            JSONResponseData(kindOfService: .exerciseDetails(id: view.exerciseId), completion: {
                (JSONdata) in

                guard let data = JSONdata else {
                    view.reloadButton(isShowing: true)
                    view.viewLoader(false)
                    return
                }
                do {
                    let parsedData = try Singleton.decoder.decode(ExerciseDetail.self, from: data)
                    view.exerciseInfo = parsedData
                    DispatchQueue.main.async {
                        view.categoryLabel.text? += (view.exerciseInfo!.category?.name)!
                        view.exerciseDescriptionTextView.text = view.exerciseInfo?.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        view.mainMuscleLabel.text? += view.makeListSentence(list: view.exerciseInfo?.mainMuscles)
                        view.secondaryMusclesLabel.text? += view.makeListSentence(list: view.exerciseInfo?.secondaryMuscles)
                        view.equipmentLabel.text? += view.makeListSentence(list: view.exerciseInfo?.equipment)
                        view.viewLoader(false)
                    }
                } catch {
                    view.reloadButton(isShowing: true)
                    view.viewLoader(false)
                }
            })
        }
    }
    
    private func reloadButton(isShowing: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isShowing
        navigationItem.rightBarButtonItem?.tintColor = isShowing ? UIColor.white : UIColor.clear
    }
    
    private func makeListSentence(list: [Result]?) -> String {
        guard let response = list else { return "" }
        switch response.count {
        case 0:
            return Constants.UIElements.nonApplicable
        case 1:
            return response.first!.name
        case 2:
            return response.first!.name + Constants.UIElements.connector + response.last!.name
        default:
            var currentIndex = 0
            var sentence = ""
            let _ = response.map { word in
                if currentIndex + 1 == response.count {
                    return
                }
                currentIndex += 1
                sentence.append(word.name + ", ")
            }
            return sentence + Constants.UIElements.connector + response.last!.name
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
            if (NetworkReachabilityManager()?.isReachable)! {
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
            } else {
                setDumbbellPlaceholder()
            }
            return
        }
        exerciseImages.append(UIImage(data: storedImage as Data)!)
        generateExerciseGIF(Constants.UIElements.exerciseGIF)
    }
    
    // Hides/Shows vissual effect + activity indicator view
    private func viewLoader(_ isVisible: Bool) {
        loadingVisualEffectView.isHidden = !isVisible
    }
    
    private func setDumbbellPlaceholder() {
        exerciseImageView.image = #imageLiteral(resourceName: "dumbbell")
        imageActivityIndicator.stopAnimating()
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
