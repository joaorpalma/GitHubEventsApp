//
//  WebService.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

protocol WebService {
    func getRequest<T: Codable>(requestUri: String, completion: @escaping CompletionWebHandler<T>) -> String
    //swiftlint:disable identifier_name
    func cancelRequest(_ id: String)
    //swiftlint:enable identifier_name
}
