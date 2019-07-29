//
//  NewsListInteractorOutput.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

protocol NewsListInteractorOutput: class{
    var view: NewsListView? { get }
    var categorizedEntries: [(category: String, entries: [Entry])] { get set }
    func fetched(_ data: Data?)
    func fetchFailed(_ error: Error)
}

extension NewsListInteractorOutput {
    func fetched(_ data: Data?) {
        guard let data = data else {
            // viewになんもない時の処理。
            return
        }
        guard let fetchEntries = XMLFormatters().xmlFormatToEntrys(result: data) else {
            return
        }
        // ここに整形する場所を入れる
        let categorizedEntry = EntryFormatter().toCategorizedEntries(entries: fetchEntries)
        // viewに渡す。
        view?.showNewsList(categorizedEntriesTappleArray: categorizedEntry)
    }
    
    func fetchFailed(_ error: Error) {
        let message = error.getErrorMessage()
        // view.showError
        view?.showErrorView(message: message)
    }
}
