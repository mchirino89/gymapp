//
//  Localizator.swift
//  GymsyApp
//
//  Created by Mauricio Chirino on 12/1/18.
//  Copyright © 2018 3CodeGeeks. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: Constants.file.dictionary.rawValue, ofType: Constants.typeOfExtension.plist.rawValue) {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Dictionary file NOT found")
    }()
    
    func localize(keyValue: String) -> String {
        guard let translation = localizableDictionary.value(forKey: keyValue) else { return "" }
        guard let localizedString = translation as? String else {
            assertionFailure("Missing translation for: \(keyValue)")
            return ""
        }
        return localizedString
    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(keyValue: self)
    }
}
