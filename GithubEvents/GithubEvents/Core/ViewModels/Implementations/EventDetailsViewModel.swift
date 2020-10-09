//
//  EventDetailsViewModel.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

class EventDetailsViewModel: ViewModelBase {
    private(set) var event: Event!

    private(set) lazy var openGithubUserCommand = Command(_openGithubUser)
    private(set) lazy var openGithubRepoCommand = Command(_openGithubRepo)

    override func prepare(dataObject: Any) {
        guard let eventObj = dataObject as? Event else { _goBack(); return }
        event = eventObj
    }

    private func _openGithubUser() {
        UrlHelper.open(url: event.getUserGithubURL())
    }

    private func _openGithubRepo() {
        UrlHelper.open(url: event.getRepositoryURL())
    }

    private func _goBack() {
        navigationService.close(arguments: nil, animated: true)
    }
}
