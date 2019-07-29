//
//  UIView+.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

extension UIView {
    // 名前を表示できるようにしている。UITableViewCellでUINib(name: ) のところを簡単にしたいから。
    var className: String {
        return String(describing: type(of: self)) // ClassName
    }
}
