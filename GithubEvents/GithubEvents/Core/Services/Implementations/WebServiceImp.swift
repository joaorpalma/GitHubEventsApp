//
//  WebServiceImp.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

import Foundation
import Networking

class WebServiceImp: WebService {
    private let _dialogService: DialogService

    private let _baseUrl: String = "https://api.github.com/"
    private let _networking = Networking()

    init(dialogService: DialogService) {
        _dialogService = dialogService
    }

    func getRequest<T>(requestUri: String, completion: @escaping CompletionWebHandler<T>) -> String where T: Decodable, T: Encodable {
        let requestId = _networking.get(_baseUrl + requestUri) { result in
            self._handleJSONResult(result, completion)
        }

        return requestId
    }

    private func _handleJSONResult<T: Codable>(_ result: JSONResult, _ completion: CompletionWebHandler<T>) {
        switch result {
        case .success(let response):
            do {
                let obj = try JSONDecoder().decode(T.self, from: response.data)
                completion(.success(obj))
            } catch {
                completion(.failure(ServerErrorType.dataError))
            }

        case .failure:
            completion(.failure(ServerErrorType.noConnection))
        }
    }
    //swiftlint:disable identifier_name
    func cancelRequest(_ id: String) {
        _networking.cancel(id)
    }
    //swiftlint:enable identifier_name
}
