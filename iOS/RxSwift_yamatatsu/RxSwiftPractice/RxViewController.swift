//
//  RxViewController.swift
//  RxSwiftPractice
//
//  Created by yamamoto.tatsuya on 2019/07/30.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import RxSwift
import RxCocoa

class RxViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    @IBOutlet weak var countResetButton: UIButton!
    
    // お決まりの書き方
    private let bag = DisposeBag()
    private var viewModel: CounterRxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = CounterRxViewModel()
        
        // ボタンをViewModelに渡して、tap イベントを観測した時の、メソッドを入れている。
        let input = CounterViewModelInput(
                            // ボタンの tap を observable にしている
            countUpButton: countUpButton.rx.tap.asObservable(),
            countDownButton: countDownButton.rx.tap.asObservable(),
            countResetButton: countResetButton.rx.tap.asObservable()
        )
        viewModel.setup(input: input)
        
        // この辺は RxCocoa らしいよ。
        viewModel.outputs?.counterText
            .drive(countLabel.rx.text)
            .disposed(by: bag) // disposeで購読の解除を行っている
    }
}
