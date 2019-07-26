//
//  NewsDetailCell.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

final class NewsDetailCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsTextViewHeight: NSLayoutConstraint!
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            newsTitle.text = title
        }
    }
    
    var content: String? {
        didSet {
            guard let html = content else { return }
            
            // html化
            let attributedString = NSAttributedString.parseHTML2Text(sourceText: html)
            newsTextView.attributedText = attributedString
            
            // 高さ調節
            let sizeThatShouldFitTheContent = newsTextView.sizeThatFits(newsTextView.frame.size)
            let height = sizeThatShouldFitTheContent.height
            newsTextViewHeight.constant = height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsTextView.isEditable = false
        newsTextView.isScrollEnabled = false
    }

}
