//
//  NewsViewController.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/23.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol NewsListView: class {
    func showNewsList(categorizedEntriesTappleArray: [(category: String, entries: [Entry])])
    func showErrorView(message: String)
}

/*
 達成したいこと。
 一つの配列を持ってくるだけでOKにしたい。
 タプルでも、
 */

final class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var bag = DisposeBag()
    
    private let refreshCtl = UIRefreshControl()
    
    private let headerViewHeight: CGFloat = 44
    private let margin: CGFloat = 20
    
    var categorizedEntriesTappleArray: [(category: String, entries: [Entry])]?
    
    var presenter: NewsListPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
        Progress.show()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        title = "ニュース一覧"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: NewsCell.className, bundle: nil), forCellReuseIdentifier: NewsCell.description())
        
        tableView.refreshControl = refreshCtl
        refreshCtl.tintColor = UIColor.gray
    }
    
    private func setupRx() {
        // 以下のメソッドがRxに変更される。
        // refreshCtl.addTarget(self, action: #selector(presenter.pullToRefresh), for: .valueChanged)
        refreshCtl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { (_) in
                Progress.show()
                self.presenter.pullToRefresh()
            })
            .disposed(by: bag)
    }
}

extension NewsListViewController: NewsListView {
    func showNewsList(categorizedEntriesTappleArray: [(category: String, entries: [Entry])]) {
        self.categorizedEntriesTappleArray = categorizedEntriesTappleArray
        tableView.reloadData()
        refreshCtl.endRefreshing()
        Progress.dismiss()
    }
    
    func showErrorView(message: String) {
        Progress.showError(with: message)
        refreshCtl.endRefreshing()
        Progress.dismiss()
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let tmpEntries = categorizedEntriesTappleArray?[indexPath.section].entries else {
            return
        }
        let entry = tmpEntries[indexPath.row]
        Progress.show()
        self.presenter.dedSelectNews(with: entry)
    }
}

extension NewsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorizedEntriesTappleArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = categorizedEntriesTappleArray?[section].entries else {
            return 0
        }
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.description(), for: indexPath) as! NewsCell
        guard let entries = categorizedEntriesTappleArray?[indexPath.section].entries else {
            return UITableViewCell()
        }
        let entry = entries[indexPath.row]
        cell.setupUi(entry: entry)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorizedEntriesTappleArray?[section].category
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerViewHeight))
        headerView.backgroundColor = .lightGray
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionTitleLabel.text = categorizedEntriesTappleArray?[section].category
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        sectionTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: margin).isActive = true
        sectionTitleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: margin).isActive = true
        
        return headerView
    }
}
