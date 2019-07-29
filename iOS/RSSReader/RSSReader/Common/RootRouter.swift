//
//  RootRouter.swift
//  RSSReader
//
//  Created by Tatsuya Yamamoto on 2019/7/27.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import UIKit // こいつないとエラー。

protocol RootWireframe: class {
    func showRootScreen(xmlUrl: String)
}

public class RootRouter: RootWireframe {
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func showRootScreen(xmlUrl: String) {
        let initVC = NewsListRouter.assembleModule(xmlUrl: xmlUrl)
        window.rootViewController = initVC
        window.makeKeyAndVisible()
    }
}
