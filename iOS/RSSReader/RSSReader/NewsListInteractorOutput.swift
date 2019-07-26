//
//  NewsListInteractorOutput.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

protocol NewsListInteractorOutput: class{
    var entries: [Entry] { get set }
    func fetched(_ data: Data?)
    func fetchFailed(_ error: Error)
}

extension NewsListInteractorOutput {
    func fetched(_ data: Data?) {
        guard let data = data else {
            // viewになんもない時の処理。
            return
        }
        let fetchEntries = XMLFormatters().xmlFormatToEntrys(result: data)
    }
    
    func fetchFailed(_ error: Error) {
        let message = error.getErrorMessage()
        // view.showError
    }
}
