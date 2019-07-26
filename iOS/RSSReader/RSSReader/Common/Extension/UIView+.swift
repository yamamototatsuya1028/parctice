//
//  UIView+.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

extension UIView {
    var className: String {
        return String(describing: type(of: self)) // ClassName
    }
}
