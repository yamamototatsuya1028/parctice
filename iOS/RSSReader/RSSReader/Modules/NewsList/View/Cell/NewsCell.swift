//
//  NewsCell.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

final class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    
    var entry: Entry? {
        didSet {
            guard let entry = entry else { return }
            newsTitle.text = entry.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUi(entry: Entry) {
        self.entry = entry
    }
    
}
