//
//  StringExtensions.swift
//  GithubEvents
//
//  Created by João Palma on 27/09/2020.
//

import Foundation

extension String {
    func camelCaseToWord() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                if $0.count > 0 {
                    return ($0 + " " + String($1))
                }
            }
            return $0 + String($1)
        }
    }

    func removeSpaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
}
