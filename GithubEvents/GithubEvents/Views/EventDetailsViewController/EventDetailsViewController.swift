//
//  EventDetailsViewController.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit

class EventDetailsViewController: FormBaseViewController<EventDetailsViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Event"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        _setupView()
    }

    private func _setupView() {
        _configureFormView()
        _titleCardLabel("User")
        _createUserDetailCard()
        _titleCardLabel("Event Details")
        _createEventDetailCard()
    }

    private func _configureFormView() {
        formViewAlignment = .top
        formContainerStackView.spacing = 20
        formContainerStackView.layoutMargins = .init(top: 24, left: 14, bottom: 14, right: 12)
    }

    private func _createUserDetailCard() {
        let picture = AspectFitImageView(image: nil, cornerRadius: 34)
        picture.backgroundColor = UIColor.Theme.transparentBlack
        picture.withSize(CGSize(width: 68, height: 68))
        picture.sd_setImage(with: viewModel.event.getProfileImageURL(), completed: nil)

        let githubImage = UIImageView(image: UIImage(named: "Github")).withSize(CGSize(width: 16, height: 16))
        let githubLinkButton = _linkButton(viewModel.event.getGithubLinkName(), #selector(_openProfile))

        let githubView = UIView().hstack(
            githubImage,
            githubLinkButton,
            UIView(),
            spacing: 7,
            alignment: .center
        )

        let name = UILabel.init(text: viewModel.event.getProfileName(), font: .systemFont(ofSize: 15, weight: .semibold), textColor: UIColor.Theme.white, numberOfLines: 1)
        name.setupShadow(opacity: 0.5, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)

        let userDetailView = UIView().stack(
            name,
            githubView,
            spacing: 10
        )

        let view = UIView().hstack(
            picture,
            userDetailView,
            spacing: 20,
            alignment: .center
        )

        let userBackgroundView = ShadowBackgroundView()
        formContainerStackView.addArrangedSubview(userBackgroundView)

        let cardView = UIView()
        userBackgroundView.addSubview(cardView)
        cardView.roundBorder(color: UIColor.Theme.mainGrey, radius: 5)
        cardView.fillSuperview()

        cardView.addSubview(view)
        view.fillSuperview(padding: .init(top: 15, left: 20, bottom: 15, right: 20))
    }

    private func _titleCardLabel(_ label: String) {
        let titleLabel = UILabel(text: label, font: .boldSystemFont(ofSize: 30), textColor: UIColor.Theme.white, textAlignment: .left)
        titleLabel.setupShadow(opacity: 1, radius: 1, offset: CGSize(width: 0.7, height: 0.7), color: UIColor.Theme.black)
        formContainerStackView.addArrangedSubview(titleLabel)
    }

    private func _linkButton(_ name: String, _ selector: Selector) -> UIButton {
        let button = UIButton.init(title: name, titleColor: UIColor.Theme.blue, font: .systemFont(ofSize: 12), target: self, action: selector)
        button.underline()
        return button
    }

    private func _createEventDetailCard() {
        let repositoryItem = _imageWithLabel(image: "folder.fill", label: viewModel.event.getRepositoryName(), isSystemImage: true)
        let eventItem = _imageWithLabel(image: viewModel.event.getImageName(), label: viewModel.event.getTypeName(), isSystemImage: false)
        let eventDateItem = _imageWithLabel(image: "calendar", label: viewModel.event.getDate(), isSystemImage: true)

        let eventDetails = UIView().stack(
            _titleLabel("Repository"),
            repositoryItem,
            _githubLink(),
            _titleLabel("Event"),
            eventItem,
            eventDateItem,
            UIView(),
            spacing: 10
        )

        let eventBackgroundView = ShadowBackgroundView()
        formContainerStackView.addArrangedSubview(eventBackgroundView)

        let cardView = UIView()
        eventBackgroundView.addSubview(cardView)
        cardView.fillSuperview()
        cardView.roundBorder(color: UIColor.Theme.mainGrey, radius: 5)

        cardView.addSubview(eventDetails)
        eventDetails.fillSuperview(padding: .allSides(20))
    }

    private func _titleLabel(_ name: String) -> UILabel {
        let label = UILabel.init(text: name, font: .systemFont(ofSize: 20, weight: .semibold), textColor: UIColor.Theme.white, numberOfLines: 1)
        label.setupShadow(opacity: 0.5, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)
        return label
    }

    private func _githubLink() -> UIView {
        let urlLinkImage = UIImageView(image: UIImage(systemName: "link")?.withTintColor(UIColor.Theme.white, renderingMode: .alwaysOriginal)).withSize(CGSize(width: 20, height: 20))
        let githubLinkButton = _linkButton(viewModel.event.getRepositoryLinkName(), #selector(_openRepo))

        return UIView().hstack(
            urlLinkImage,
            githubLinkButton,
            UIView(),
            spacing: 10,
            alignment: .center
        ).padBottom(12.5)
    }

    private func _imageWithLabel(image: String, label: String, isSystemImage: Bool) -> UIView {
        let image =  UIImageView(image: isSystemImage ? UIImage(systemName: image)?.withTintColor(UIColor.Theme.white, renderingMode: .alwaysOriginal) : UIImage(named: image))
                        .withSize(CGSize(width: 20, height: 20))

        let label = UILabel.init(text: label, font: .systemFont(ofSize: 15, weight: .semibold), textColor: UIColor.Theme.lightGrey)

        return UIView().hstack(
            image,
            label,
            spacing: 10,
            alignment: .center
        ).padTop(10)
    }

    @objc private func _openProfile() {
        viewModel.openGithubUserCommand.execute()
    }

    @objc private func _openRepo() {
        viewModel.openGithubRepoCommand.execute()
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
