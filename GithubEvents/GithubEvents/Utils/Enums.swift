//
//  Enums.swift
//  GithubEvents
//
//  Created by João Palma on 24/09/2020.
//

import UIKit

enum ServerErrorType: String, Error {
    case noConnection = "No internet connection, please try again later."
    case serverNotFound = "Something went wrong, try again!"
    case dataError = "Data received from the server as invalid. Please try again."
}

enum EventType: String {
    case watchEvent = "WatchEvent"
    case pushEvent = "PushEvent"
    case createEvent = "CreateEvent"
    case issueEvent = "IssueEvent"
    case deleteEvent = "DeleteEvent"
    case forkEvent = "ForkEvent"
    case issueCommentEvent = "IssueCommentEvent"
    case publicEvent = "PublicEvent"
    case pullRequestEvent = "PullRequestEvent"
    case pullRequestReviewCommentEvent = "PullRequestReviewCommentEvent"
    case pullRequestReviewEvent = "PullRequestReviewEvent"
    case releaseEvent = "ReleaseEvent"
    case otherEvent = "EventAlert"

    static let containsImage = [watchEvent, pushEvent, createEvent, issueEvent, deleteEvent, forkEvent]
}

enum EventFilter: String, CaseIterable {
    case all = "All"
    case watchEvent = "Watch Event"
    case pushEvent = "Push Event"
    case createEvent = "Create Event"
    case issueEvent = "Issue Event"
    case others = "Others"

    static let allValues = [all, watchEvent, pushEvent, createEvent, issueEvent, others]
}

enum InfoDialogType {
    case good
    case bad
    case info
}

enum FormAlignment {
    case top, center
}

extension InfoDialogType: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.Theme.green: self = .good
        case UIColor.Theme.red: self = .bad
        case UIColor.Theme.yellow: self = .info
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .good: return UIColor.Theme.green
        case .bad: return UIColor.Theme.red
        case .info: return UIColor.Theme.yellow
        }
    }
}
