//
//  HomeModule.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit

class HomeModule: Module {
    private let dataProvider: DataProvider
    
    private lazy var rootVC: UIViewController = {
        let output = HomeViewModel.Output()
        output.showListSubject
            .receive(on: DispatchQueue.main)
            .observeNext { [weak self] in self?.showList() }
            .dispose(in: bag)

        output.addShowSubject
            .receive(on: DispatchQueue.main)
            .observeNext { [weak self] in self?.showAddTVShow() }
            .dispose(in: bag)
        
        let vm = HomeViewModel(input: HomeViewModel.Input(), output: output)
        return HomeViewController(viewModel: vm)
    }()
    
    override func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
    
    init(router: Router, dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(router: router)
        router.setRoot(rootVC)
    }
    
    private func showList() {
        let output = ShowListViewModel.Output()
        let input = ShowListViewModel.Input()
        
        let vm = ShowListViewModel(input: input, output: output, dataProvider: dataProvider)
        
        router.push(ShowListViewController(viewModel: vm))
    }
    
    private func showAddTVShow() {
        let output = AddShowViewModel.Output()
        let input = AddShowViewModel.Input()
        
        output.alertSubject.bind(to: alertSubject)
        
        let vm = AddShowViewModel(input: input, output: output, dataProvider: dataProvider)
        
        router.push(AddShowViewController(viewModel: vm))
    }
}
