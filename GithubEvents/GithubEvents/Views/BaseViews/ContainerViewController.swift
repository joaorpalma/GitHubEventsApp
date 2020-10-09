//
//  ContainerViewController.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import UIKit

class ContainerViewController: UIViewController {
    private(set) var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func changeViewController(_ viewController: UIViewController) {
        guard _checkIfCurrentViewControllerIsNotEqualsToNew(viewController) else { return }

        _removeCurrentViewController()
        _addNewViewControllerToContainer_(viewController)
    }

    private func _checkIfCurrentViewControllerIsNotEqualsToNew(_ viewController: UIViewController) -> Bool {
        return currentViewController != viewController.self
    }

    private func _removeCurrentViewController() {
        if currentViewController != nil {
            self.willMove(toParent: nil)
            currentViewController!.removeFromParent()
            currentViewController!.view.removeFromSuperview()
            currentViewController = nil
        }
    }

    private func _addNewViewControllerToContainer_ (_ viewController: UIViewController) {
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        currentViewController = viewController
    }
}
