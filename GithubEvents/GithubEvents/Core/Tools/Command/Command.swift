//
//  Command.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

struct Command {
    private var action: CompletionHandler
    private let canExecuteAction: CanExecuteCompletionHandler

    init(_ action: @escaping CompletionHandler, canExecute: @escaping CanExecuteCompletionHandler = { true }) {
        self.action = action
        self.canExecuteAction = canExecute
    }

    func execute() {
        action()
    }

    func executeIf() {
        if canExecuteAction() {
            action()
        }
    }

    func canExecute() -> Bool {
        return canExecuteAction()
    }
}
