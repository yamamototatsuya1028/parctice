//
//  NewsDetailInteractor.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/29.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

// Viewに渡すための、delegate実装
protocol NewsDetailInteractorDelegate: class {
    var view: NewsDetailView { get }
    func gotFailed(message: String)
    func gotEntry(entry: Entry)
}

extension NewsDetailInteractorDelegate {
    func gotEntry(entry: Entry) {
        view.showNewsDetail(entry: entry)
    }
    
    func gotFailed(message: String) {
        view.showErrorMessage(message: message)
    }
}

protocol NewsDetailUsecase: class {
    func getEntry()
}

// interactor は相互作用だから、通信とかなかったら必要なさそうだな~
#warning("テストしやすくするためには必要なんかな。")
// テストしやすくするためには必要なんか?
final class NewsDetailInteractor: NewsDetailUsecase {
    var entry: Entry?
    weak var delegate: NewsDetailInteractorDelegate? // delegateをDIしなきゃいけない。assembleModuleで。
    
    func getEntry() {
        entry = nil
        guard let entry = entry else {
            delegate?.gotFailed(message: "データの取得ができませんでした")
            return
        }
        delegate?.gotEntry(entry: entry)
    }
}
