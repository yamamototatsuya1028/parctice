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
    static func assembleModule(xmlUrl: String) -> UIViewController
}

final class NewsListRouter: NewsListWireframe {
    // 弱参照やけど、なんでだろう。
    weak var viewController: UIViewController?
    // required はなんでだろう。
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    static func assembleModule(xmlUrl: String) -> UIViewController {
        let view = NewsListViewController.instantiate()
        let interactor = NewsListInteractor()
        let router = NewsListRouter(viewController: view)
        
        let presenter = NewsListPresenter(view: view, router: router, interactor: interactor, xmlUrl: xmlUrl)
        
        view.presenter = presenter
        interactor.output = presenter
        
        let navi = UINavigationController(rootViewController: view)
        return navi
    }
    
    func pushNewsDetailView(_ entry: Entry) {
        let VC = NewsDetailViewController.instantiate()
        // ここを assembleModuleに変えなきゃ
        VC.entry = entry
        self.viewController?.navigationController?.pushViewController(VC, animated: true)
    }
}
