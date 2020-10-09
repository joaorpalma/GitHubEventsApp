//
//  EventPayload.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct EventPayloadStruct: Codable {
    let commits: [CommitStruct]?
    let action: String?
    let issue: IssueStruct?
}
