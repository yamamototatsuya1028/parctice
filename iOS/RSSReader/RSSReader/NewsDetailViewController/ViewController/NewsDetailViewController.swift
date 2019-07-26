//
//  NewsDetailViewController.swift
//  RSSReader
//
//  Created by yamamoto.tatsuya on 2019/07/24.
//  Copyright © 2019 yamamoto.tatsuya. All rights reserved.
//

import UIKit

final class NewsDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ニュース詳細"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: NewsDetailCell.className, bundle: nil), forCellReuseIdentifier: NewsDetailCell.description())
        tableView.register(UINib(nibName: ImageCell.className, bundle: nil), forCellReuseIdentifier: ImageCell.description())
    }
}

extension NewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension NewsDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        guard let linkCount = entry?.links.count else { return 0 }
        return linkCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let entry = entry else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailCell.description(), for: indexPath) as! NewsDetailCell
            cell.title = entry.title
            cell.content = entry.content
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.description(), for: indexPath) as! ImageCell
            cell.title = entry.links[indexPath.row].title
            cell.imageUrl = entry.links[indexPath.row].href
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}
