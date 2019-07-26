//
//  ViewController.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/23.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

final class EntryOperation {
    
    private var xmlUrl = URL(string: "https://www.apple.com/jp/newsroom/rss-feed.rss")
    // エラー出すために間違ってるURLを使ってみる
    // private var xmlUrl = URL(string: "https://www.apple.com/jp/newsroom/rss-feed.rs")
    
    private var categories: [String] = []
    private var entries: [Entry] = []
    private var entriesSeparatedByCategory: [String:[Entry]] = [:]
    
    func getEntries(completion: @escaping ([String:[Entry]])->()) {
        // fetchしたあとにセットする。
        fetchXMLData() {
            self.setCategories()
            self.setEntries()
            completion(self.entriesSeparatedByCategory)
        }
    }
    
    func setCategories() {
        // 全てのカテゴリを入れている
        for entry in self.entries {
            categories.append(entry.category)
        }
        // カテゴリをユニークにしている
        categories = categories.unique
    }
    
    func setEntries() {
        for category in categories {
            entriesSeparatedByCategory.updateValue(getEntries(by: category), forKey: category)
        }
    }
    
    func getEntries(by category: String) -> [Entry] {
        var entreisEqualCategory:[Entry] = []
        for entry in entries {
            if entry.category == category {
                entreisEqualCategory.append(entry)
            }
        }
        return entreisEqualCategory
    }
}

extension EntryOperation {
    func fetchXMLData(completion: @escaping ()->()) {
        AF.request(xmlUrl!).response { (response) in
            switch response.result {
            case .success(let result):
                let xml = SWXMLHash.parse(result!)
                do {
                    let fetchEntries: [Entry] = try xml["feed"]["entry"].value()
                    debugPrint("🌞成功")
                    self.entries = fetchEntries
                    completion()
                } catch {
                    // エラー処理
                    debugPrint("😈失敗")
                    Progress.showError(with:
                    "xmlファイルの形式が異なるため、表示することができませんでした")
                    completion()
                }
            case .failure(let error):
                debugPrint("😈通信エラー詳細：\(error)")
                Progress.showError(with: error.getErrorMessage())
            }
        }
    }
}
