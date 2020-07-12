//
//  AddShowViewModel.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import Bond
import ReactiveKit

class AddShowViewModel: ViewModel, ViewModelType {
    struct Cell {
        let title: String
        let year: String
        let sessions: String
    }
    
    struct Output {
        let alertSubject = PassthroughSubject<AlertConfig, Never>()
        let addButtonEnabled = Observable<Bool>(false)
        
        let yearPlaceholder = "input_year".localized
        let movieTitlePlaceholder = "input_movie_title".localized
        let sessionPlaceholder = "input_sessions".localized
        let buttonTitle = "add_button_title".localized

    }
    
    struct Input {
        let addButtonTap = PassthroughSubject<Void, Never>()
        let showTitle = Observable<String?>("")
        let year = Observable<String?>("")
        let sessions = Observable<String?>("")
    }
    
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
        let inputs = combineLatest(input.showTitle, input.year, input.sessions)
        let unwrappedInputs = combineLatest(input.showTitle.unwrap(), input.year.unwrap(), input.sessions.unwrap())

        let isValid = inputs
            .map { !($0.0?.isEmpty ?? true) && !($0.1?.isEmpty ?? true) && !($0.2?.isEmpty ?? true) }

        input.addButtonTap
            .with(latestFrom: isValid.filter { $0 })
            .with(latestFrom: unwrappedInputs)
            .map { $1 }
            .observeNext { [weak self] in self?.addShow(title: $0.0, year: $0.1, sessions: $0.2) }
            .dispose(in: bag)
        
        isValid.bind(to: output.addButtonEnabled)
    }
    
    private func addShow(title: String, year: String, sessions: String) {
        guard let yearDate = Date.parse(string: year) else {
            let alertConfig = AlertConfig(title: "bad_year_format".localized)
            self.output.alertSubject.send(alertConfig)
            return
        }
        
        guard let session = Int(sessions) else {
            let alertConfig = AlertConfig(title: "bad_sessions_format".localized)
            self.output.alertSubject.send(alertConfig)
            return
        }
        
        let show = TVShow(title: title,
                          year:  Calendar.current.component(.year, from: yearDate),
                          sessions: session)
        
        loadingState.send(.loading)
       
        dataProvider.saveObject(object: show) { [weak self] success in
            guard let self = self else { return }
            
            self.loadingState.send(.finished)
            
            let alertConfig = AlertConfig(
                title: success ? "add_success".localized : "add_fail".localized
            )
            
            self.output.alertSubject.send(alertConfig)
        }
    }
}
