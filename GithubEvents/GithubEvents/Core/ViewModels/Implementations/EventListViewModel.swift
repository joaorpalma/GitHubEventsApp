//
//  MainViewModel.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import RxSwift
import Foundation

class EventListViewModel: ViewModelBase {
    private let _eventWebService: EventWebService
    private let _dialogService: DialogService

    let isBusy = BehaviorSubject<Bool>(value: false)
    let events = BehaviorSubject<[Event]>(value: [])
    let isFiltering = BehaviorSubject<Bool>(value: false)
    var isFetching: Bool { !_canExecute() }

    private var _eventList: [Event] = []
    private var _selectedFilterEvent = EventFilter.all

    private(set) lazy var fetchEventsCommand = Command(_refreshEvents, canExecute: _canExecute)
    private(set) lazy var openFilterCommand = Command(_openFilterDialog, canExecute: _canExecute)
    private(set) lazy var openEventDetailCommand = WpCommand<Int>(_openEventDetail)

    init(eventWebService: EventWebService, dialogService: DialogService) {
        self._eventWebService = eventWebService
        self._dialogService = dialogService
    }

    override func initialize() {
        _fetchEvents()
    }

    private func _fetchEvents() {
        isBusy.onNext(true)

        DispatchQueue.main.async {
            self._eventWebService.getEvents(completion: { [weak self] events in self?._eventsCompletion(events) })
        }
    }

    private func _eventsCompletion(_ result: Result<[EventStruct]?, ServerErrorType>) {
        isBusy.onNext(false)

        switch result {
        case .success(let eventStructList):
            let eventList = eventStructList?.map({ event -> Event in Event(event) })
            _updateEvents(eventList!)
        case .failure(let error):
            _dialogService.showInfo(error.rawValue, informationType: .bad)
            _updateEvents(_eventList)
        }
    }

    private func _updateEvents(_ eventList: [Event]) {
        _eventList = eventList
        _filterEvent(_selectedFilterEvent)
    }

    private func _refreshEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            self._fetchEvents()
        }
    }

    private func _openEventDetail(_ index: Int) {
        do {
            if let event = try events.value()[safe: index] {
                navigationService.navigate(viewModel: EventDetailsViewModel.self, arguments: event, animated: true)
            }
        } catch {
            return
        }
    }

    private func _openFilterDialog() {
        let eventIndex = EventFilter.allValues.firstIndex(of: _selectedFilterEvent)!
        _dialogService.showFilter(eventIndex, _filterEvent)
    }

    private func _filterEvent(_ eventFilter: EventFilter) {
        _selectedFilterEvent = eventFilter
        let eventFilterValue = _selectedFilterEvent.rawValue.removeSpaces()

        switch eventFilterValue {
        case EventFilter.all.rawValue:
            _removeFiltersFromEventList()
        case EventType.watchEvent.rawValue:
            _filterEventListBy(event: EventType.watchEvent)
        case EventType.pushEvent.rawValue:
            _filterEventListBy(event: EventType.pushEvent)
        case EventType.createEvent.rawValue:
            _filterEventListBy(event: EventType.createEvent)
        case EventType.issueEvent.rawValue:
            _filterEventListBy(event: EventType.issueEvent)
        default:
            _filterEventListByOtherEvents()
        }

        _checkIfListIsFiltering(eventFilterValue)
    }

    private func _removeFiltersFromEventList() {
        events.onNext(_eventList)
    }

    private func _filterEventListBy(event eventType: EventType) {
        let eventListFiltered = _eventList.filter { event in
            return event.isEventOfType(eventType)
        }

        events.onNext(eventListFiltered)
    }

    private func _filterEventListByOtherEvents() {
        let eventListFiltered = _eventList.filter { event in
            return !(event.isEventOfType(EventType.watchEvent) || event.isEventOfType(EventType.pushEvent)
                 || event.isEventOfType(EventType.createEvent) || event.isEventOfType(EventType.issueEvent))
        }

        events.onNext(eventListFiltered)
    }

    private func _checkIfListIsFiltering(_ filter: String) {
        isFiltering.onNext(filter != EventFilter.all.rawValue)
    }

    private func _canExecute() -> Bool {
        do {
            return try !isBusy.value()
        } catch {
            return true
        }
    }
}
