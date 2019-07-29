//
//  NewsDetailRouter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/29.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

protocol NewsDetailWireframe: class {
    var viewController: UIViewController? { get set}
    init(viewController: UIViewController?)
    static func assembleModule(entry: Entry) -> UIViewController
}

final class NewsDetailRouter: NewsDetailWireframe {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    
    static func assembleModule(entry: Entry) -> UIViewController {
        let view = NewsDetailViewController.instantiate()
        let interactor = NewsDetailInteractor()
        let router = NewsDetailRouter(viewController: view)
        
        let presenter = NewsDetailPresenter(view: view, interactor: interactor, router: router)
        
        interactor.entry = entry
        interactor.delegate = presenter
        view.presenter = presenter
        return view
    }
    
}
