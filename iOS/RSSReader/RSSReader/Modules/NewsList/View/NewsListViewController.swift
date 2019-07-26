//
//  NewsViewController.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/23.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit
import Alamofire

final class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshCtl = UIRefreshControl()
    
    private let headerViewHeight: CGFloat = 44
    private let margin: CGFloat = 20
    
    var entries: [String:[Entry]] = [:]
    var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ニュース一覧"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: NewsCell.className, bundle: nil), forCellReuseIdentifier: NewsCell.description())
        
        tableView.refreshControl = refreshCtl
        refreshCtl.tintColor = UIColor.gray
        refreshCtl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        loadData()
    }
    
    @objc func loadData() {
        // interactor　が、Operationのような役割
        EntryOperation().getEntries { (fetchEntries) in
            self.entries = fetchEntries
            self.categories = [String](self.entries.keys)
            self.tableView.reloadData()
            self.refreshCtl.endRefreshing()
        }
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entries = entries[categories[indexPath.section]] else {
            return
        }
        let entry = entries[indexPath.row]
        let VC = NewsDetailViewController.instantiate()
        VC.entry = entry
        navigationController?.pushViewController(VC, animated: true)
    }
}

extension NewsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = entries[categories[section]] else {
            return 0
        }
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.description(), for: indexPath) as! NewsCell
        guard let entries = entries[categories[indexPath.section]] else {
            return UITableViewCell()
        }
        let entry = entries[indexPath.row]
        cell.title = entry.title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerViewHeight))
        headerView.backgroundColor = .lightGray
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionTitleLabel.text = categories[section]
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        sectionTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: margin).isActive = true
        sectionTitleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: margin).isActive = true
        
        return headerView
    }
}
