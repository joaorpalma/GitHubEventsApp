//
//  ViewModelBase.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

class ViewModelBase: ViewModel {
    private(set) var navigationService: NavigationService = DiContainer.resolve()

    func prepare(dataObject: Any) {}
    func initialize() {}
    func appearing() {}
    func disappearing() {}
    func backAction() {}
}
