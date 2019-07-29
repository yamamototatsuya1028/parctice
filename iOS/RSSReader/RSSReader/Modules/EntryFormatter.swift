//
//  EntryFormatter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/29.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

struct EntryFormatter {
    
    /// from Entry Array to CategorizedEnties Tapple Array because dictionary don't have index, so ViewController needs Entry Array and Category Array
    ///
    /// - Parameter entries: array
    /// - Returns: tapple array
    func toCategorizedEntries(entries:[Entry]) -> [(category: String, entries: [Entry])] {
        
        var categories:[String] = []
        for entry in entries {
            categories.append(entry.category)
        }
        // カテゴリをユニークにしている
        categories = categories.unique
        
        var entriesSeparatedByCategory: [(category: String, entries: [Entry])] = []
        for category in categories {
            entriesSeparatedByCategory.append((category,getEntries(by: category, entries: entries)))
        }
        
        return entriesSeparatedByCategory
    }
    
    func getEntries(by category: String, entries: [Entry]) -> [Entry] {
        var entreisEqualCategory:[Entry] = []
        for entry in entries {
            if entry.category == category {
                entreisEqualCategory.append(entry)
            }
        }
        return entreisEqualCategory
    }
}
