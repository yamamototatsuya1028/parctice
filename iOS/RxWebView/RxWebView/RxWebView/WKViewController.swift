//
//  WKViewController.swift
//  RxWebView
//
//  Created by yamamoto.tatsuya on 2019/07/30.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import WebKit

class WKViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        // observer を利用して、webViewを監視している。
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        let url =  URL(string: "https://www.google.com")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        progressView.setProgress(0.1, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            UIApplication.shared
                .isNetworkActivityIndicatorVisible = webView.isLoading
            if !webView.isLoading {
                progressView.setProgress(0.0, animated: false)
                navigationItem.title = webView.title
            }
        }
        
        if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

}
