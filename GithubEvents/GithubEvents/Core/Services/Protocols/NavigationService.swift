//
//  NavigationService.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

protocol NavigationService {
    func navigate<TViewModel: ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool)
    func navigateAndSetAsContainer<TViewModel: ViewModel>(viewModel: TViewModel.Type)
    func close(arguments: Any?, animated: Bool)
}
