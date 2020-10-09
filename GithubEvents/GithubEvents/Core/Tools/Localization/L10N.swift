//
//  L10N.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import Foundation

struct L10N {
    static private var _currentLanguage: String?
    static private let _supportedLanguages: [String] = ["en", "pt"]
    static private let _defaultLanguage: String = "en"

    static private var _resourceManager: [LiteralObject] = []
    static private var resourcesManager: [LiteralObject] {
        if _resourceManager.isEmpty {
            _setLanguage()
            _loadJsonString()
        }

        return _resourceManager
    }

    static func getCurrentLanguage() -> String {
        if _currentLanguage == nil {
            _setLanguage()
        }

        return _currentLanguage!
    }

    static func localize(key: String) -> String {
        let value = resourcesManager.first(where: { $0.key == key })
        return value?.translated ?? ""
    }

    static private func _setLanguage() {
        let lang = String(Locale.preferredLanguages.first!)
        let split = lang.split(separator: "-")
        let language = String(split[0])

        _currentLanguage = _supportedLanguages.first(where: { $0 == language }) ?? _defaultLanguage
    }

    static private func _loadJsonString() {
        guard let path = Bundle.main.path(forResource: _currentLanguage, ofType: "json") else {
            print("No json file found.")
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
            if let result = jsonResult {
                for (key, value) in result {
                    //swiftlint:disable force_cast
                    _resourceManager.append(LiteralObject(key: key as! String, translated: value as! String))
                    //swiftlint:enable forece_cast
                }
            }
        } catch let error {
           print(error)
        }
    }
}
