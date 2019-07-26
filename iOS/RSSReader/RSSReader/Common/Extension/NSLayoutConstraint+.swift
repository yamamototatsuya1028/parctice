//
//  NSLayoutConstraint+.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
