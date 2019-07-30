//
//  CounterViewModel.swift
//  RxSwiftPractice
//
//  Created by yamamoto.tatsuya on 2019/07/30.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import RxSwift
import RxCocoa

// Observableで、観測可能なものを定義する
/*
 イベント処理の流れ
 これまで挙げたコード例はほとんど同じ形をしていました。
 
 Observable ＝ イベントが流れてくる Sequence
 rx.tap, rx.text, rx.notification, rx.response
 Observable を subscribe するとイベントを受け取れる
 dispose ＝ subscription の破棄
 これが RxSwift の基本的な使い方です。
 */
struct CounterViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

// こいつは delegate　みたいなもんか？
protocol CounterViewModelOutput {
    
    /*
     Driver (RxCocoa)
     Observer の処理を MainScheduler で実行 →　main thread と一緒！！！
     エラーは無視
     shareReplayLatestWhileConnected() する
     UI イベントを扱うのに使うとコードがスッキリする
     こいつを参照して、UIを変更するかメインスレッドで変更するようにしている。
     */
    var counterText: Driver<String?> { get }
}

protocol CounterViewModelType {
    var outputs: CounterViewModelOutput? { get }
    func setup(input: CounterViewModelInput)
}

class CounterRxViewModel: CounterViewModelType {
    var outputs: CounterViewModelOutput?
    /// データバインディング
    /*
     アプリ設計において、値の変化をどう伝えるかは重要な関心ごとのひとつです。
     
     モデルの値の変化を UI に伝えたい
     UI の値の変化をモデルに伝えたい
     それを実現する手段はいくつか考えられますが、その手段のひとつとして RxSwift が有力です。
     
     逆に言えば、RxSwift が注目される理由のひとつが、このデータバインディングです。ここに焦点を当てて、RxSwift に再入門してみたいと思います。
     */
    
    // BehaviorSubject は最後の値を覚えていて、subscribeすると即座にそれを最初に通知する Subject です。生成するときに初期値を指定できます。
    private let countRelay = BehaviorRelay<Int>(value: 0)
    private let initialCount = 0
    private let bag = DisposeBag()
    
    init() {
        // delegateを入れてるんだろうな〜
        self.outputs = self
        resetCount()
    }
    
    func setup(input: CounterViewModelInput) {
        // 購読を開始するぞ！
        input.countUpButton
            .subscribe(onNext: { [weak self] in
                // イベントが発火した時。
                self?.incrementCount()
            })
            .disposed(by: bag)
        
        input.countDownButton
            .subscribe(onNext: { [weak self] in
                self?.decrementCount()
                })
            .disposed(by: bag)
        
        input.countResetButton
            .subscribe(onNext: { [weak self] in
                self?.resetCount()
                })
            .disposed(by: bag)
    }
    
    /*
     accept で Relay に .next イベントを送ることができます。Observable の外側からイベントを流すことができるわけです。
     なお、コードは BehaviorRelay ですが、PublishRelay でも使い方は同じです。
     */
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }
    
    private func resetCount() {
        countRelay.accept(initialCount)
    }
}

extension CounterRxViewModel: CounterViewModelOutput {
    var counterText: Driver<String?> {
        return countRelay
            .map{ "Rxパターン： \($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
}
