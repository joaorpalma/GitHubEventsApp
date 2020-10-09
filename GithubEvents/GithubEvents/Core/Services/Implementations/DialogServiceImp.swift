//
//  DialogServiceImp.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

class DialogServiceImp: DialogService {
    func showInfo(_ description: String, informationType: InfoDialogType) {
        let infoView = InfoDialogView()
        infoView.showInfo(text: description, infoType: informationType)
    }
    func showFilter(_ selectedEventFilterIndex: Int, _ eventHandler: @escaping CompletionHandlerWithParam<EventFilter>) {
        let filterView = FilterDialogView()
        filterView.showFilter(selectedEventFilterIndex, eventHandler)
    }
}
