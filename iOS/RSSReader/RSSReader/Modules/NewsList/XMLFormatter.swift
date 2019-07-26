//
//  XMLFormatter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import SWXMLHash

struct XMLFormatters {
    
    func xmlFormatToEntrys(result: Data) -> [Entry]? {
        let xml = SWXMLHash.parse(result)
        do {
            let fetchEntries: [Entry] = try xml["feed"]["entry"].value()
            debugPrint("🌞XMLの解体に成功")
            return fetchEntries
        } catch {
            // エラー処理
            debugPrint("😈XMLの解体に失敗！")
            Progress.showError(with:
                "xmlファイルの形式が異なるため、表示することができませんでした")
        }
        return nil // エラー処理は渡し先に任せたほうがいいのかな？ここの責務は解体するだけ。
    }
    
}
