//
//  EventWebService.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

protocol EventWebService {
    @discardableResult
    func getEvents(completion: @escaping CompletionWebHandler<[EventStruct]>) -> String
    //swiftlint:disable identifier_name
    func cancelRequest(id: String)
    //swiftlint:enable identifier_name
}
