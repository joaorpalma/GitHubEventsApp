//
//  CollectionExtensions.swift
//  GithubEvents
//
//  Created by João Palma on 06/10/2020.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
