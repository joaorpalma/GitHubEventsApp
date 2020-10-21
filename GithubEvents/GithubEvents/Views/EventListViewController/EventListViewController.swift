//
//  MainViewController.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import UIKit
import RxSwift

class EventListViewController: BaseViewController<EventListViewModel> {
    private let _tableView = UITableView()
    private lazy var _dataSourceProvider = EventListDataSource(tableView: _tableView, events: viewModel.events, eventHandler: _selectedEventAtIndex)
    private lazy var _activityIndicatorView = createActivityIndicatory(view: self.view)
    private let _refreshControl = UIRefreshControl()
    private let _disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github Events"
        _setupView()
    }

    private func _setupView() {
        _configureFilterButton()
        _configureTableView()
        _configureActivityIndicator()
    }

    private func _configureFilterButton() {
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle")?.withTintColor(UIColor.Theme.white,
                                            renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(_filterButton))

        filterButton.tintColor = UIColor.Theme.lightGrey
        self.navigationItem.rightBarButtonItem = filterButton

        viewModel.isFiltering.subscribe(onNext: { isFiltering in
            let image = isFiltering ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle"
            filterButton.image = UIImage(systemName: image)?.withTintColor(UIColor.Theme.white, renderingMode: .alwaysOriginal)
        }).disposed(by: _disposeBag)
    }

    private func _configureTableView() {
        self.view.addSubview(_tableView)
        _tableView.rx.base.delegate = _dataSourceProvider

        _tableView.anchor(top: self.view.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)

        _configureTableViewRefreshControl()
        _configureEmptyListLabel()
    }

    private func _configureTableViewRefreshControl() {
        _tableView.refreshControl = _refreshControl
        _refreshControl.addTarget(self, action: #selector(_refreshEvents), for: .valueChanged)
        viewModel.isBusy.bind(onNext: { [weak self] isBusy in
            if !isBusy {
                self?._refreshControl.endRefreshing()
            }
        }).disposed(by: _disposeBag)
    }

    private func _configureEmptyListLabel() {
        let noFlightsLabel = UILabel(text: "No Events 👎", font: .boldSystemFont(ofSize: 13), textColor: UIColor.Theme.lightGrey, textAlignment: .center)

        self.view.addSubview(noFlightsLabel)
        noFlightsLabel.centerXTo(self.view.centerXAnchor)
        noFlightsLabel.centerYTo(self.view.centerYAnchor)

        viewModel.events.subscribe(onNext: { event in
            noFlightsLabel.isHidden = self.viewModel.isFetching || !event.isEmpty
        }).disposed(by: _disposeBag)
    }

    private func _configureActivityIndicator() {
        viewModel.isBusy.bind(to: _activityIndicatorView.rx.isAnimating).disposed(by: _disposeBag)
    }

    private func _selectedEventAtIndex(_ index: Int) {
        viewModel.openEventDetailCommand.execute(index)
    }

    @objc private func _refreshEvents(_ sender: AnyObject) {
        _refreshControl.beginRefreshing()
        viewModel.fetchEventsCommand.executeIf()
    }

    @objc private func _filterButton() {
        viewModel.openFilterCommand.executeIf()
    }
}
