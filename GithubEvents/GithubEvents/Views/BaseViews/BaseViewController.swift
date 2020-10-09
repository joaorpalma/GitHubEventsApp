//
//  BaseViewController.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import UIKit

class BaseViewController<TViewModel: ViewModel>: UIViewController {
    var parameterData: Any?

    private(set) var viewModel: TViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        _setViewConfigurations()
        _instantiateViewModel()
    }

    private func _setViewConfigurations() {
        view.backgroundColor = UIColor.Theme.darkGrey
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func _instantiateViewModel() {
        let viewM: TViewModel = DiContainer.resolve()

        if let data = parameterData {
            viewM.prepare(dataObject: data)
        }

        viewModel = viewM
        viewModel?.initialize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.appearing()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.disappearing()
    }
}
