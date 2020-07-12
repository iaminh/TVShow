//
//  HomeViewController.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit

class HomeViewController: Controller<HomeViewModel> {
    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            mainImageView.image = vm.output.mainImage
        }
    }
    @IBOutlet weak var addShowButton: UIButton! {
        didSet {
            addShowButton.setTitle(vm.output.addShowButtontitle, for: .normal)
        }
    }
    @IBOutlet weak var showListButton: UIButton! {
        didSet {
            showListButton.setTitle(vm.output.showListButtonTitle, for: .normal)
        }
    }
    
    override func bindToVM() {
        super.bindToVM()
        navigationItem.title = vm.output.navTitle
        addShowButton.reactive.tap.bind(to: vm.input.addShowButtonTapSubject)
        showListButton.reactive.tap.bind(to: vm.input.showListButtonTapSubject)
    }
}
