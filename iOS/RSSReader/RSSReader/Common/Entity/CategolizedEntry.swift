//
//  CategolizedEntry.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

struct CategolizedEntry {
    let categolizedEntry: KeyValuePairs<String, [Entry]>
    init(_ data: KeyValuePairs<String, [Entry]>) {
        categolizedEntry = data
    }
}
