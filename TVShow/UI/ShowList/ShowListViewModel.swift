//
//  ShowListViewModel.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class ShowListViewModel: ViewModel, ViewModelType {
    struct Cell {
        let title: String
        let subtitle: String
        let bottomTitle: String
        
        init(show: TVShow) {
            title = show.title
            subtitle = String(show.year)
            bottomTitle = "movie_sessions".localize(with: [String(show.sessions)])
        }
    }
    
    struct Output {
        let navTitle = "show_list_title".localized
        let cells = Observable<[Cell]>([])
        let alertSubject = PassthroughSubject<AlertConfig, Never>()
    }
    
    struct Input { }
    
    let input: Input
    let output: Output
    
    private let dataProvider: DataProvider
    
    init(input: Input, output: Output, dataProvider: DataProvider) {
        self.input = input
        self.output = output
        self.dataProvider = dataProvider
        
        super.init()

        bindInputOutput()
    }
    
    private func bindInputOutput() {
        lifeCycle.didAppearSubject
            .observeNext { [weak self] in
                let handler: (Result<[TVShow], DataProvider.ProviderError>) -> Void = { [weak self] result in
                    guard let self = self else { return }
                    self.loadingState.send(.finished)
                    switch result {
                    case .failure:
                        self.output.alertSubject.send(AlertConfig(title: "loading_error"))
                    case .success(let shows):
                        log.message("Successfully loaded \(shows)")
                        self.output.cells.send(shows.map { Cell(show: $0) })
                    }
                }
                
                self?.loadingState.send(.loading)
                self?.dataProvider.getObjects(completion: handler)
            }.dispose(in: bag)
    }
}
