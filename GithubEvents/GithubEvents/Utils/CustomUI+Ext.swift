//
//  UIExtensions.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import UIKit

struct CustomUIAppearance {
    static func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.Theme.mainGrey
        appearance.titleTextAttributes = [.foregroundColor: UIColor.Theme.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Theme.white, .shadow: _textShadow()]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        UINavigationBar.appearance().standardAppearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().compactAppearance?.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().scrollEdgeAppearance?.backButtonAppearance = backButtonAppearance

        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.Theme.white], for: .normal)
        UIBarButtonItem.appearance().tintColor = UIColor.Theme.white
    }

    static private func _textShadow() -> NSShadow {
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.Theme.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
    }
}

extension UIColor {
    func fromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }

    struct Theme {
        static var mainGrey = UIColor().fromRGBA(red: 34, green: 35, blue: 40, alpha: 1.0)
        static var white = UIColor().fromRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)
        static var black = UIColor().fromRGBA(red: 0, green: 0, blue: 0, alpha: 1.0)
        static var darkGrey = UIColor().fromRGBA(red: 29, green: 30, blue: 33, alpha: 1.0)
        static var lightGrey = UIColor().fromRGBA(red: 149, green: 152, blue: 158, alpha: 1.0)
        static var transparentBlack = UIColor().fromRGBA(red: 0, green: 0, blue: 0, alpha: 0.4)
        static var blue = UIColor().fromRGBA(red: 62, green: 154, blue: 255, alpha: 1.0)
        static var green = UIColor().fromRGBA(red: 65, green: 169, blue: 75, alpha: 1.0)
        static var red = UIColor().fromRGBA(red: 229, green: 38, blue: 23, alpha: 1.0)
        static var yellow = UIColor().fromRGBA(red: 237, green: 202, blue: 45, alpha: 1.0)
    }
}

extension UIView {
    func removeAllSubViews() {
          self.subviews.forEach({ $0.removeFromSuperview() })
    }

    func roundBorder(color: UIColor, radius: CGFloat) {
        backgroundColor = color
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
