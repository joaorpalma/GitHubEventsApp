//
//  MainDataSource.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit
import RxSwift
import RxCocoa

class EventListDataSource: NSObject, UITableViewDelegate {
    private let _cellIdentifier = "EventListCell"
    private let _tableView: UITableView
    private let _events: BehaviorSubject<[Event]>
    private var _selectEventCompletionHandler: CompletionHandlerWithParam<Int>
    private let _disposeBag = DisposeBag()

    init(tableView: UITableView, events: BehaviorSubject<[Event]>, eventHandler: @escaping CompletionHandlerWithParam<Int>) {
        _events = events
        _selectEventCompletionHandler = eventHandler

        _tableView = tableView
        _tableView.backgroundColor = UIColor.clear
        _tableView.separatorStyle = .none
        _tableView.register(EventListCell.self, forCellReuseIdentifier: _cellIdentifier)

        super.init()

        _bindTableView()
    }

    private func _bindTableView() {
        _events.bind(to: _tableView.rx.items(cellIdentifier: _cellIdentifier, cellType: EventListCell.self)) { (_, item, cell) in
            cell.config(item)
        }.disposed(by: _disposeBag)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _selectEventCompletionHandler(indexPath.row)
    }
}
