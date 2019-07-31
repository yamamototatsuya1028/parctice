//
//  RxWebViewViewController.swift
//  RxWebView
//
//  Created by yamamoto.tatsuya on 2019/07/31.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional

class RxWebViewViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    // お決まり
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        
        let loadingObservable =
            webView.rx.observe(Bool.self, "loading").filterNil().share()
     
        loadingObservable
            .map { return !$0 }
            .bind(to: progressView.rx.isHidden)
            .disposed(by: bag)
        
        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: bag)
        
        loadingObservable
            .map{ [weak self] _ in return self?.webView.title}
            .bind(to: navigationItem.rx.title)
            .disposed(by: bag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .filterNil()
            .map { return Float($0)}
            .bind(to: progressView.rx.progress)
            .disposed(by: bag)
        
       
        
        let url =  URL(string: "https://www.google.com")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
    
}
