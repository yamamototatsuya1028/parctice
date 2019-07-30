//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by yamamoto.tatsuya on 2019/07/30.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

// 責務は、Viewの変更をするだけ。
// やったらダメなこと。データの保持
class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    // MVVM パターン
    // private var viewModel: CounterViewModel!
    
    private let presenter = CounterPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewModel = CounterViewModel()
        presenter.attachView(self)
    }

    @IBAction func countUp(_ sender: Any) {
//        viewModel.incrementCount(callback: {[weak self] count in
//            self?.updateCountLabel(count)
//        })
        presenter.incrementCount()
    }
    
    @IBAction func countDown(_ sender: Any) {
//        viewModel.decrementCount(callback: {[weak self] count in
//            self?.updateCountLabel(count)
//        })
        presenter.decrementCount()
    }
    
    @IBAction func countReset(_ sender: Any) {
//        viewModel.resetCount(callback: {[weak self] count in
//            self?.updateCountLabel(count)
//        })
        presenter.resetCount()
    }
    // もらった値を描写するだけにする。
    private func updateCountLabel(_ count: Int) {
        countLabel.text = String(count)
    }
}

extension ViewController: CounterDelegate {
    func updateCount(count: Int) {
        updateCountLabel(count)
    }
}


//
//class CounterViewModel {
//    private(set) var count = 0
//
//    func incrementCount(callback: (Int)->()) {
//        count += 1
//        callback(count)
//    }
//
//    func decrementCount(callback: (Int)->()) {
//        count -= 1
//        callback(count)
//    }
//
//    func resetCount(callback: (Int)->()) {
//        count = 0
//        callback(count)
//    }
//}

protocol CounterDelegate {
    func updateCount(count: Int)
}

class CounterPresenter {
    private var count = 0 {
        didSet {
            delegate?.updateCount(count: count)
        }
    }
    
    private var delegate: CounterDelegate?
    
    func attachView(_ delegate: CounterDelegate) {
        self.delegate = delegate
    }
    
    func detachView() {
        self.delegate = nil
    }
    
    func incrementCount() {
        count += 1
    }
    
    func decrementCount() {
        count -= 1
    }
    
    func resetCount() {
        count = 0
    }
}
