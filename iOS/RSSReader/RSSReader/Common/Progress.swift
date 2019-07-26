//
//  Progress.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/25.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import SVProgressHUD

struct Progress {
    
    static func configure() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setMinimumSize(CGSize(width: 120, height: 120))
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setFont(.boldSystemFont(ofSize: 14.0))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7043557363))
        SVProgressHUD.setMinimumDismissTimeInterval(2.0)
        SVProgressHUD.setMaximumDismissTimeInterval(10.0)
    }
    
    static func show(with message: String? = nil) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show(withStatus: message)
    }
    
    static func showError(with message: String? = nil) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    static func showSuccess(with message: String? = nil) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    static func dismiss(_ completion: (() -> Void)? = nil) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SVProgressHUD.dismiss {
            completion?()
        }
    }
}
