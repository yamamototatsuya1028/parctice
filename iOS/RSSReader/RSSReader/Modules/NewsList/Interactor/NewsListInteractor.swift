//
//  NewsListInteractor.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/// 「データに関わるロジック」を担当(取得、加工、保存など)
/// Presenterから依頼されたデータを取得し返す
/// 取得が完了したらPresenterに通知
/// クロージャ(おすすめ)、またはDelegate経由で返す
/// 戻り値で返さないほうが、UnitテストのためのMock作成が楽になる
/// 循環参照にならないよう実装注意
/// WebAPI、バンドルされたファイル、ローカルに保存されているデータなど
/// import UIKit禁止
/// UIがどうなっているかを気にしない
protocol NewsListUseCase: class {
    var output: NewsListInteractorOutput! { get }
    func fetch(by url: String)
}

#warning("いい感じにできている感じがする")
final class NewsListInteractor: NewsListUseCase {
    weak var output: NewsListInteractorOutput!
    
    func fetch(by url: String) {
        let xmlUrl = URL(string: url)
        AF.request(xmlUrl!).response { (response) in
            switch response.result {
            case .success(let data):
                debugPrint("🌞通信成功")
                self.output.fetched(data)
                
            case .failure(let error):
                debugPrint("😈通信エラー詳細：\(error)")
                self.output.fetchFailed(error)
            }
        }
    }
}

