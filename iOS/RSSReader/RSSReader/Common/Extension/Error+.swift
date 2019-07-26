//
//  Error+.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import Alamofire

extension Error {
    
    func getErrorMessage() -> String {
        
        // Alamofireのエラー対処
        if let error = self as? AFError {
            switch error {
            case .invalidURL(let url):
                return "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                return "Parameter encoding failed: \(error.localizedDescription)"
                + "Failure Reason: \(reason)"
            case .multipartEncodingFailed(let reason):
                return "Multipart encoding failed: \(error.localizedDescription)"
                + "Failure Reason: \(reason)"
            case .responseValidationFailed(let reason):
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    return "Downloaded file could not be read"
                case .missingContentType(let acceptableContentTypes):
                    return "Content Type Missing: \(acceptableContentTypes)"
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    return "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                case .unacceptableStatusCode(let code):
                    return "Response status code was unacceptable: \(code)"
                }
                
            case .responseSerializationFailed(let reason):
                return "Response serialization failed: \(error.localizedDescription)"
                    + "Failure Reason: \(reason)"
            default:
                return "Underlying error: \(String(describing: error.underlyingError))"
            }
            
        // URLのエラー対処
        } else if let error = self as? URLError {
            let apiError = APIError(errorCode: error.code.rawValue)
            return  ErrorMessage(error: apiError).errorMessage
        } else {
            // 上記以外のエラーを出力
            return "Unknown error: \(self)"
        }
    }
}
