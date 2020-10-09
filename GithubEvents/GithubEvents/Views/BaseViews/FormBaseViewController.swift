//
//  FormBaseViewController.swift
//  GithubEvents
//
//  Created by João Palma on 30/09/2020.
//

import UIKit

class FormBaseViewController<TViewModel: ViewModel>: BaseViewController<TViewModel> {
    var formViewAlignment: FormAlignment = .top
    var bottomButtonHeight: CGFloat = 0

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize = self.view.frame.size
        scrollView.keyboardDismissMode = .interactive
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    let formContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)

        if formViewAlignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                                          bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _updateScrollViewSize()
    }

    private func _updateScrollViewSize() {
        if formContainerStackView.frame.height > view.frame.height {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        } else {
            scrollView.contentSize.height = view.frame.height
        }
    }
}
