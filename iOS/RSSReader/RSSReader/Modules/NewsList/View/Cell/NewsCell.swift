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
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            newsTitle.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
