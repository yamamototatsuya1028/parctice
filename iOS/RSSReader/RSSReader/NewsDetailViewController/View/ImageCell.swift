//
//  ImageCell.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

final class ImageCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var imageAspectRatio: NSLayoutConstraint!
    
    var title: String? {
        didSet {
            guard let title = self.title else { return }
            titleLabel.text = title
        }
    }
    
    var imageUrl: String? {
        didSet {
            guard let url = imageUrl else { return }
            #warning("imageViewの処理を入れる")
            newsImageView.setImage(url: url) { image, error  in
                guard let err = error else {
                    return
                }
                guard let image = image else {
                    return
                }
                // 画像に合わせて、セルの大きさを変更している
                self.imageAspectRatio = self.imageAspectRatio.setMultiplier(multiplier: image.size.width / image.size.height)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

