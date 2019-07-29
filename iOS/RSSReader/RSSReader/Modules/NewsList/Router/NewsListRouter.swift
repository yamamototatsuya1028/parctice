//
//  NewsListRouter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/26.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
/*
 「画面遷移」と「DI」を担当
 VIPERアーキテクチャの肝であり、他の有名アーキテクチャにないところ
 他アーキテクチャではViewに画面遷移の処理もお願いする必要があり、Viewが「画面の更新」と「画面遷移」の2つを担当する必要があった
 →Viewのコードの見通しが悪くなりがちだった
 VIPERでは「画面遷移」の処理をRouterに移管したことでViewの責務を減らせた
 */
protocol NewsListWireframe: class {
    // 画面遷移のためにViewControllerが必要。initで受け取る。
    var viewController: UIViewController? { get set}
    init(viewController: UIViewController?)
    
    func pushNewsDetailView(_ entry: Entry)
    // DI
    static func assembleModule(xmlUrl: String) -> UIViewController
}

final class NewsListRouter: NewsListWireframe {
    // 弱参照やけど、なんでだろう。
    weak var viewController: UIViewController?
    // サンプルにはrequired が必要やったけど、こいつはいらんっぽい。
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    static func assembleModule(xmlUrl: String) -> UIViewController {
        let view = NewsListViewController.instantiate()
        let interactor = NewsListInteractor()
        let router = NewsListRouter(viewController: view)
        
        // ここでDIしてる。 依存関係を減らして、テストしやすくしている。
        let presenter = NewsListPresenter(view: view, router: router, interactor: interactor, xmlUrl: xmlUrl)
        view.presenter = presenter
        
        // delegate を渡している！！！
        interactor.output = presenter
        
        let navi = UINavigationController(rootViewController: view)
        return navi
    }
    
    func pushNewsDetailView(_ entry: Entry) {
        // ここはprotocol のメソッドは呼べないみたい。static だからかな？
        // error : Static member 'assembleModule' cannot be used on protocol metatype 'NewsDetailWireframe.Protocol'
        let VC = NewsDetailRouter.assembleModule(entry: entry)
        self.viewController?.navigationController?.pushViewController(VC, animated: true)
    }
}
