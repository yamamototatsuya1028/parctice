//
//  NewsListRouter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

protocol NewsListWireframe: class {
    var viewController: UIViewController? { get set}
    init(viewController: UIViewController?)
    
    func pushNewsDetailView(_ entry: Entry)
    static func assembleModule() -> UIViewController
}

final class NewsListRouter: NewsListWireframe {
    // 弱参照やけど、なんでだろう。
    weak var viewController: UIViewController?
    // required はなんでだろう。
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        return NewsListViewController.instantiate()
    }
    
    func pushNewsDetailView(_ entry: Entry) {
        let VC = NewsDetailViewController.instantiate()
        self.viewController?.navigationController?.pushViewController(VC, animated: true)
    }
}
