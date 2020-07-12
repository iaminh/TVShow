//
//  Controller.swift
//  HomeCredit

import UIKit
import Bond
import ReactiveKit

class Controller<VM: ViewModel>: BaseViewController {
    public let vm: VM

    init(viewModel: VM) {
        self.vm = viewModel
        super.init(nibName: NSStringFromClass(type(of: self)).components(separatedBy: ".").last, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        vm.lifeCycle.didLoadSubject.send()
        super.viewDidLoad()
        bindToVM()
    }

    override func viewWillAppear(_ animated: Bool) {
        vm.lifeCycle.willAppearSubject.send()
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        vm.lifeCycle.didAppearSubject.send()
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        vm.lifeCycle.willDisappearSubject.send()
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        vm.lifeCycle.didDisappearSubject.send()
        super.viewDidDisappear(animated)
    }

    func bindToVM() {
        vm.loadingState.receive(on: DispatchQueue.main)
            .observeNext { [weak self] (state) in
                switch state {
                case .loading:
                    self?.showActivityIndicator()
                default:
                    self?.hideActivityIndicator()
                }
            }.dispose(in: bag)
    }
}
