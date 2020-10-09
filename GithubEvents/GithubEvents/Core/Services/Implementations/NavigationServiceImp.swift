//
//  NavigationServiceImp.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import UIKit

class NavigationServiceImp: NavigationService {
    private var _containerViewController: ContainerViewController?

    func navigate<TViewModel: ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        _containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }

    func navigateAndSetAsContainer<TViewModel: ViewModel>(viewModel: TViewModel.Type) {
        let viewController: UIViewController = _getViewController(type: viewModel)
        _setNewContainerViewController(UINavigationController(rootViewController: viewController))
    }

    private func _getViewController<TViewModel: ViewModel>(type: TViewModel.Type, args: Any? = nil) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)

        if let arguments = args, let viewC = viewController as? BaseViewController<TViewModel> {
            viewC.parameterData = arguments
        }

        return viewController
    }

    private func _setNewContainerViewController(_ viewController: UIViewController) {
        //swiftlint:disable force_cast
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        //swiftlint:enable force_cast
        _containerViewController = sceneDelegate.containerViewController
        _containerViewController?.changeViewController(viewController)
    }

    func close(arguments: Any?, animated: Bool) {
        _containerViewController?.navigationController?.popViewController(animated: true)
    }
}
