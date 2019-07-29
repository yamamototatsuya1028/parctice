//
//  NewsDetailPresenter.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/29.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation

protocol NewsDetailPresentation: class {
    var view: NewsDetailView? { get }
    
    init(
        view: NewsDetailView,
        interactor: NewsDetailUsecase,
        router: NewsDetailWireframe
    )
    func viewDidLoad()
}

final class NewsDetailPresenter: NewsDetailPresentation {
    var view: NewsDetailView?
    private let router: NewsDetailWireframe
    private let interactor: NewsDetailUsecase
    
    func viewDidLoad() {
        interactor.fetch()
    }
    
    
    
    
    
    init(view: NewsDetailView, interactor: NewsDetailUsecase, router: NewsDetailWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    weak var output: NewsListInteractorOutput!
    
    func fetch() {
        
    }
}
