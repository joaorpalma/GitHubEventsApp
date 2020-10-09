//
//  EventCell.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit
import SDWebImage

class EventListCell: UITableViewCell {
    func config(_ event: Event) {
        self.removeAllSubViews()
        _createCardEvent(event)
    }

    private func _createCardEvent(_ event: Event) {
        _createCardShadow()

        var cardView = UIView()
        self.addSubview(cardView)
        cardView.roundBorder(color: UIColor.Theme.mainGrey, radius: 5)
        cardView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 2, right: 10))

        _addUserAndDate(&cardView, event)
        _addEvent(&cardView, event)
    }

    private func _createCardShadow() {
        let shadowView = ShadowBackgroundView()
        self.addSubview(shadowView)
        shadowView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 2, right: 10))
    }

    private func _addUserAndDate(_ cardView: inout UIView, _ event: Event) {
        let date = UILabel.init(text: event.getHours(), font: .systemFont(ofSize: 13, weight: .medium), textColor: UIColor.Theme.lightGrey)
        date.setupShadow(opacity: 0.5, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)
        date.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)

        let dateImage = UIImageView(image: UIImage(systemName: "clock.fill")?.withTintColor(UIColor.Theme.white, renderingMode: .alwaysOriginal)).withSize(CGSize(width: 18, height: 18))

        let dateView = UIView().hstack(
            dateImage,
            date,
            spacing: 6,
            alignment: .center
        )

        cardView.addSubview(dateView)
        dateView.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 17))

        let picture = AspectFitImageView(image: nil, cornerRadius: 14)
        picture.backgroundColor = UIColor.Theme.transparentBlack
        picture.withSize(CGSize(width: 28, height: 28))
        picture.sd_setImage(with: event.getProfileImageURL(), completed: nil)

        let name = UILabel.init(text: event.getProfileName(), font: .systemFont(ofSize: 14, weight: .semibold), textColor: UIColor.Theme.white)
        name.setupShadow(opacity: 0.5, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)
        name.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)

        let stackUser = UIView().hstack(
            picture,
            name,
            UIView(),
            spacing: 12,
            alignment: .center
        ).padTop(13).padLeft(17).padRight(6)

        cardView.addSubview(stackUser)
        stackUser.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: dateView.leadingAnchor)
    }

    private func _addEvent(_ cardView: inout UIView, _ event: Event) {
        let eventImage = UIImageView(image: UIImage(named: event.getImageName())).withSize(CGSize(width: 20, height: 20))

        cardView.addSubview(eventImage)
        eventImage.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 55, left: 21, bottom: 11, right: 0))

        let eventText = _createEventText("\(event.getTypeName()) on ", event.getRepositoryName())

        cardView.addSubview(eventText)
        eventText.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor,
                         padding: .init(top: 56.5, left: 50, bottom: 11, right: 21))
    }

    private func _createEventText(_ text1: String, _ text2: String) -> UILabel {
        let attrs1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.Theme.lightGrey]
        let attrs2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.Theme.white]
        let attributedString1 = NSMutableAttributedString(string: text1, attributes: attrs1)
        let attributedString2 = NSMutableAttributedString(string: text2, attributes: attrs2)

        attributedString1.append(attributedString2)

        let event = UILabel()
        event.attributedText = attributedString1
        event.numberOfLines = 0

        return event
    }
}
