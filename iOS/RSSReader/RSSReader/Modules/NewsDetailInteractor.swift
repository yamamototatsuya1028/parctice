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
    func gotEntry(entry: Entry)
}

extension NewsDetailInteractorDelegate {
    func gotEntry(entry: Entry) {
        view.showNewsDetail(entry: entry)
    }
}

protocol NewsDetailUsecase: class {
    func getEntry()
}

// interactor は相互作用だから、通信とかなかったら必要なさそうだな~
// テストしやすくするためには必要なんか。
final class NewsDetailInteractor: NewsDetailUsecase {
    var entry: Entry?
    weak var delegate: NewsDetailInteractorDelegate? // delegateをDIしなきゃいけない。assembleModuleで。
    
    func getEntry() {
        guard let entry = entry else {
            return
        }
        delegate?.gotEntry(entry: entry)
    }
}
