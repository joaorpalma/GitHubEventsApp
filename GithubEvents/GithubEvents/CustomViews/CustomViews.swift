//
//  CustomViews.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit

class ShadowBackgroundView: UIView {
    private let cornerRadius: CGFloat
    private var shadowLayer: CAShapeLayer!

    init(cornerRadius: CGFloat = 5) {
        self.cornerRadius = cornerRadius
        super.init(frame: CGRect())
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer != nil {
            layer.sublayers?.filter { $0 is CAShapeLayer }.forEach {
                $0.removeFromSuperlayer()
            }
        }

        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.shadowColor = UIColor.Theme.transparentBlack.withAlphaComponent(0.22).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.85, height: 0.85)
        shadowLayer.shadowOpacity = 3
        shadowLayer.shadowRadius = 2

        layer.insertSublayer(shadowLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

func createActivityIndicatory(view: UIView) -> UIActivityIndicatorView {
    let activityView = UIActivityIndicatorView(style: .large)
    activityView.center = view.center
    view.addSubview(activityView)

    return activityView
}
