//
//  ViewModel.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

protocol ViewModel {
    func prepare(dataObject: Any)
    func initialize()
    func appearing()
    func disappearing()
}
