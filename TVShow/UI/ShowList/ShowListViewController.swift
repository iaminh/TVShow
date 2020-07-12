//
//  ShowListViewController.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit
import Bond

class ShowListViewController: Controller<ShowListViewModel> {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    override func bindToVM() {
        super.bindToVM()
        
        vm.output.cells.bind(to: tableView) { array, indexPath, tableView in
            let data = array[indexPath.row]
            let cell: ShowTableViewCell = tableView.dequeue(for: indexPath)
            cell.configure(with: data)
            return cell
        }.dispose(in: bag)
    }

    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(ShowTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
    }
}
