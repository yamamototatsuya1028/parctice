//
//  APIError.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum APIError: Error {
    case badRequest
    case fobiddenRequest
    case notFound
    case responseError
    case unexpectedError
    
    init(errorCode: Int) {
        if errorCode == 404 {
            self = .notFound
        } else if errorCode == 403 {
            self = .fobiddenRequest
        } else if errorCode == 400 {
            self = .badRequest
        } else {
            self = .unexpectedError
        }
    }
}

struct ErrorMessage {
    
    let errorMessage: String
    
    init(error: Error) {
        if case APIError.notFound = error {
            errorMessage = "ページが存在しません"
        } else if case APIError.badRequest = error {
            errorMessage = "不正なリクエストです"
        } else if case APIError.fobiddenRequest = error {
            errorMessage = "アクセス権限がありません"
        } else {
            errorMessage = "通信エラーです"
        }
    }
}
