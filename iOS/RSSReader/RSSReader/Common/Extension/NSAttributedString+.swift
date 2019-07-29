//
//  NSAttributedString+.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

extension NSAttributedString {
    /// HTMLに変換するよ
    ///
    /// - Parameter text: xmlから持ってきたコードの、content部分を変換している
    /// - Returns: NSAttributedStringを返して、TextViewで表示するといい感じになります。
    static func parseHTML2Text(sourceText text: String) -> NSAttributedString? {
        let encodeData = text.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let attributedOptions = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html as AnyObject,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue as AnyObject
        ]
        
        var attributedString: NSAttributedString?
        if let encodeData = encodeData {
            do {
                attributedString = try NSAttributedString(
                    data: encodeData,
                    options: attributedOptions,
                    documentAttributes: nil
                )
            } catch _ {
                // TODO: エラー処理入れなきゃ
            }
        }
        return attributedString
    }
    
}
