//
//  HomeViewModel.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class HomeViewModel: ViewModel, ViewModelType {
    struct Output {
        let showListSubject = PassthroughSubject<Void, Never>()
        let addShowSubject = PassthroughSubject<Void, Never>()
        
        let addShowButtontitle = "add_show_button_title".localized
        let navTitle = "home_title".localized
        let showListButtonTitle = "show_list_button_title".localized
        let mainImage = UIImage(named: "breaking-bad")
    }
    
    struct Input {
        let addShowButtonTapSubject = PassthroughSubject<Void, Never>()
        let showListButtonTapSubject = PassthroughSubject<Void, Never>()
    }
    
    let input: Input
    let output: Output
    
    init(input: Input, output: Output) {
        self.input = input
        self.output = output
        
        super.init()
        
        bindInputOutput()
    }
    
    private func bindInputOutput() {
        input.addShowButtonTapSubject.bind(to: output.addShowSubject)
        input.showListButtonTapSubject.bind(to: output.showListSubject)
    }
}
