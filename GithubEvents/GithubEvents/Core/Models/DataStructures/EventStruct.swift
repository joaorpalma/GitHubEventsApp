//
//  Events.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct EventStruct: Codable {
    let type: String
    let actor: ActorStruct
    let repo: RepositoryStruct
    let payload: EventPayloadStruct
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case type, actor, repo, payload
        case createdAt = "created_at"
    }
}
