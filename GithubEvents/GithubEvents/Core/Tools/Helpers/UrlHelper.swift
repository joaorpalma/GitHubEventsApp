//
//  UrlHelper.swift
//  GithubEvents
//
//  Created by João Palma on 30/09/2020.
//

import UIKit

struct UrlHelper {
    static func open(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
