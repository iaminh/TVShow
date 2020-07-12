//
//  AddShowViewController.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class AddShowViewController: Controller<AddShowViewModel> {
    @IBOutlet private weak var titleTF: UITextField! {
        didSet {
            titleTF.placeholder = vm.output.movieTitlePlaceholder
        }
    }
    @IBOutlet private weak var yearTF: UITextField! {
        didSet {
            yearTF.placeholder = vm.output.yearPlaceholder
        }
    }
    @IBOutlet private weak var sessionTF: UITextField! {
        didSet {
            sessionTF.placeholder = vm.output.sessionPlaceholder
        }
    }
    @IBOutlet private weak var addButton: UIButton! {
        didSet {
            addButton.setTitle(vm.output.buttonTitle, for: .normal)
        }
    }
    
    override func bindToVM() {
        super.bindToVM()
    
        navigationItem.title = title
        
        titleTF.reactive.text.bind(to: vm.input.showTitle)
        yearTF.reactive.text.bind(to: vm.input.year)
        sessionTF.reactive.text.bind(to: vm.input.sessions)
    
        vm.output.addButtonEnabled.bind(to: addButton.reactive.isEnabled)
        addButton.reactive.tap.bind(to: vm.input.addButtonTap)
    }

}
