//
//  EventWebServiceImp.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

class EventWebServiceImp: EventWebService {
    private let _webService: WebService

    init(webService: WebService) {
        self._webService = webService
    }

    func getEvents(completion: @escaping CompletionWebHandler<[EventStruct]>) -> String {
        let cancelationToken = _webService.getRequest(requestUri: "events", completion: { events in completion(events) })
        return cancelationToken
    }
    //swiftlint:disable identifier_name
    func cancelRequest(id: String) {
        _webService.cancelRequest(id)
    }
    //swiftlint:enable identifier_name
}
