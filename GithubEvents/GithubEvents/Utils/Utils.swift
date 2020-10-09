//
//  Utils.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit

struct Utils {
    static let keyWindow: UIWindow = UIApplication.shared.windows.first {$0.isKeyWindow}!
}

struct LocalConstants {
    static var AlertDialogHeight: CGFloat = 50.0
}

struct Animations {
    static func slideVerticaly(_ view: UIView, showAnimation: Bool, duration: Double = 0.35, delay: CGFloat = 0, completion: ((Bool) -> Void)?) {
        let minTransform = CGAffineTransform.init(translationX: 0, y: -view.bounds.height)
        let maxTransform = CGAffineTransform.identity

        view.alpha = showAnimation ? 0 : 1
        view.transform = showAnimation ? minTransform : maxTransform

        UIView.animate(withDuration: duration, delay: TimeInterval(delay),
                       options: UIView.AnimationOptions.curveEaseOut, animations: {
                            view.alpha = showAnimation ? 1 : 0
                            view.transform = showAnimation ? maxTransform : minTransform
                       }, completion: completion)
    }
}
