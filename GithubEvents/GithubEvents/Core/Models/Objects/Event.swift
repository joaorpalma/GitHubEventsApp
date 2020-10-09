//
//  Event.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import Foundation

struct Event {
    private let _event: EventStruct
    private var _eventType: EventType!

    init(_ event: EventStruct) {
        _event = event
        _eventType = _setType(event.type)
    }

    func getProfileImageURL() -> URL {
        URL(string: _event.actor.avatarURL)!
    }

    func getProfileName() -> String {
        _event.actor.login
    }

    func getGithubLinkName() -> String {
        "github.com/\(_event.actor.login)"
    }

    func getUserGithubURL() -> URL {
        URL(string: "https://github.com/\(_event.actor.login)")!
    }

    func getHours() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm:ss"
        guard let date = DateFormatter.date(fromISO8601String: _event.createdAt) else { return "" }
        return dateFormatterPrint.string(from: date)
    }

    func getDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM, dd · HH:mm:ss"
        guard let date = DateFormatter.date(fromISO8601String: _event.createdAt) else { return "" }
        return dateFormatterPrint.string(from: date)
    }

    func getRepositoryName() -> String {
        let repoName = _event.repo.name

        if let range = repoName.range(of: "/") {
            let name = repoName[range.upperBound...]
            return String(name)
        } else {
            return repoName
        }
    }

    func getRepositoryLinkName() -> String {
        "github.com/\(getRepositoryName())"
    }

    func getRepositoryURL() -> URL {
        URL(string: "https://github.com/\(_event.repo.name)")!
    }

    func getImageName() -> String {
        if EventType.containsImage.contains(_eventType) {
            return _eventType.rawValue
        } else {
            return "EventAlert"
        }
    }

    func getTypeName() -> String {
        _eventType.rawValue.camelCaseToWord()
    }

    func isEventOfType(_ event: EventType) -> Bool {
        _eventType == event
    }

    func getPushDetails() -> [CommitStruct] {
        guard let commits = _event.payload.commits else { return [] }
        return commits
    }

    private mutating func _setType(_ eventType: String) -> EventType {
        if let event = EventType(rawValue: eventType) {
            return event
        } else {
            return EventType.otherEvent
        }
    }
}
