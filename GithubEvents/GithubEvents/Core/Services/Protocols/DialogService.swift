//
//  DialogService.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

protocol DialogService {
    func showInfo(_ description: String, informationType: InfoDialogType)
    func showFilter(_ selectedEventFilterIndex: Int, _ eventHandler: @escaping CompletionHandlerWithParam<EventFilter>)
}
