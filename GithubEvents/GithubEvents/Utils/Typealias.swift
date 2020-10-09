//
//  typeAlias.swift
//  GithubEvents
//
//  Created by João Palma on 23/09/2020.
//

typealias CompletionHandler = () -> Void
typealias CompletionHandlerWithParam<T> = (T) -> Void
typealias CanExecuteCompletionHandler = () -> (Bool)

typealias CompletionWebHandler<T> = (Result<T?, ServerErrorType>) -> Void

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}
