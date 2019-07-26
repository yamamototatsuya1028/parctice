//
//  UIImageView+Kingfisher.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url:String, completion: @escaping (UIImage?,Error?)->()) {
        kf.setImage(with: URL(string: url)) { (result) in
            switch result {
            case .success(let result):
                completion(result.image,nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
