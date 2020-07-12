//
//  ShowTableViewCell.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    @IBOutlet private weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 8
            cardView.layer.borderColor = UIColor.black.cgColor
            cardView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet private weak var topTitleLabel: UILabel!
    @IBOutlet private weak var midTitleLabel: UILabel!
    @IBOutlet private weak var bottomTitleLabel: UILabel!
    
    func configure(with cell: ShowListViewModel.Cell) {
        topTitleLabel.text = cell.title
        midTitleLabel.text = cell.subtitle
        bottomTitleLabel.text = cell.bottomTitle
    }
}
