//
//  NewsDetailInteractor.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/29.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsDetailUsecase: class {
    var output: NewsListInteractorOutput! { get }
    func fetch()
}

final class NewsDetailInteractor: NewsDetailUsecase {
    var output: NewsListInteractorOutput!
    
    func fetch() {
        
    }
    
    
    
}
