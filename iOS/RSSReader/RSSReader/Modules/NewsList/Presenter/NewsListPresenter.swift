//
//  NewsListPresenter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import RxSwift

/*
 Viewから受け取ったイベントを元に「画面の更新処理に関わるロジック」を担当
 Viewからのイベントの内容によって必要な処理を実施、または別のクラスに依頼する
 Viewに対して画面の更新依頼を投げる
 Interactorに対してデータの取得依頼を投げる
 Routerに対して画面遷移の依頼を投げる
 Presenterが提供するメソッド名は
 「画面の更新が終わった(viewDidLoad)」「ボタンが押された(hogeButtonDidPush)」
 といった命名にすること
 ×「(ボタンが押されたので)詳細画面に遷移する(showDetailView)」
 import UIKit禁止
 UIがどうなっているかを気にしない
 
 */
protocol NewsListPresentation: class {
    init(
        view: NewsListView?,
        router: NewsListWireframe,
        interactor: NewsListUseCase,
        xmlUrl: String
    )
    
    func viewDidLoad()
    func pullToRefresh()
    func dedSelectNews(with entry: Entry)
}

final class NewsListPresenter: NewsListPresentation {
    
    weak var view: NewsListView?
    var categorizedEntries: [(category: String, entries: [Entry])] = []
    private let router: NewsListWireframe
    private let interactor: NewsListUseCase
    private let xmlUrl: String
    
    init(view: NewsListView?, router: NewsListWireframe, interactor: NewsListUseCase, xmlUrl: String) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.xmlUrl = xmlUrl
    }
    
    func viewDidLoad() {
        fetchEntry(xmlUrl: xmlUrl)
    }
    
    func pullToRefresh() {
        fetchEntry(xmlUrl: xmlUrl)
    }
    
    func dedSelectNews(with entry: Entry) {
        router.pushNewsDetailView(entry)
    }
    
    private func fetchEntry(xmlUrl: String) {
        self.interactor.fetch(by: xmlUrl)
    }
}

extension NewsListPresenter: NewsListInteractorOutput {}
