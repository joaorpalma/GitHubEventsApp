//
//  Actor.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct ActorStruct: Codable {
    let login: String
    let url: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login, url
        case avatarURL = "avatar_url"
    }
}
