//
//  Core.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct Core {
    static func initialize() {
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
        _startApp()
    }

    private static func _registerServices() {
        DiContainer.registerSingleton(NavigationService.self, constructor: { NavigationServiceImp() })
        DiContainer.registerSingleton(DialogService.self, constructor: { DialogServiceImp() })
        DiContainer.registerSingleton(WebService.self, constructor: { WebServiceImp(dialogService: DiContainer.resolve()) })
        DiContainer.registerSingleton(EventWebService.self, constructor: { EventWebServiceImp(webService: DiContainer.resolve()) })
    }

    private static func _registerViewModels() {
        DiContainer.register(EventListViewModel.self, constructor: { EventListViewModel(eventWebService: DiContainer.resolve(), dialogService: DiContainer.resolve()) })
        DiContainer.register(EventDetailsViewModel.self, constructor: { EventDetailsViewModel() })
    }

    private static func _registerViewControllers() {
        DiContainer.registerViewController(EventListViewModel.self, constructor: { EventListViewController() })
        DiContainer.registerViewController(EventDetailsViewModel.self, constructor: { EventDetailsViewController() })
    }

    private static func _startApp() {
        let navigationService: NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: EventListViewModel.self)
    }
}
