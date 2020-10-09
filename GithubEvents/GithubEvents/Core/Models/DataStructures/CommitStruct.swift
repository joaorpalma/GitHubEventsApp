//
//  Commit.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct CommitStruct: Codable {
    let sha: String
    let message: String
    let url: String
}
