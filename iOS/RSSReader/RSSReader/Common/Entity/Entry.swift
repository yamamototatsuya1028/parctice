//
//  Entry.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import SWXMLHash

struct Entry: XMLIndexerDeserializable {
    let category: String
    let title: String
    let content: String
    let links: [Link]
    
    // SWXMLHash の init
    public static func deserialize(_ node: XMLIndexer) throws -> Entry {
        var links: [Link] = []
        do {
            links = try node["link"].value()
        } catch {
            // error
        }
        links = linkFilter().removeNonTitleLink(links: links)
        return try Entry (
            category: node["category"].element?.attribute(by: "term")?.text ?? "",
            title: node["title"].value(),
            content: node["content"].value(),
            links: links
        )
    }
}

struct linkFilter {
    func removeNonTitleLink(links: [Link]) -> [Link] {
        var removedLinks: [Link] = links
        var removeIndex: [Int] = []
        for (index, link) in links.enumerated() {
            if link.title == "" {
                removeIndex.append(index)
            }
        }
        removeIndex.sort { (a, b) -> Bool in
            return a > b
        }
        for index in removeIndex {
            removedLinks.remove(at: index)
        }
        return removedLinks
    }
}

struct Link: XMLIndexerDeserializable {
    let title: String
    let href: String
    let type: String
    
    // init　的な存在
    public static func deserialize(_ node: XMLIndexer) throws -> Link {
        return try Link (
            title: node.element?.attribute(by: "title")?.text ?? "",
            href: node.element?.attribute(by: "href")?.text ?? "",
            type: node.element?.attribute(by: "type")?.text ?? ""
        )
    }
}
