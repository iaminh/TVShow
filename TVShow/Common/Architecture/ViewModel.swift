//

import Foundation
import Bond
import ReactiveKit

class ViewModel {
    struct ViewLifeCycle {
        let didLoadSubject = PassthroughSubject<Void, Never>()
        let didAppearSubject = PassthroughSubject<Void, Never>()
        let didDisappearSubject = PassthroughSubject<Void, Never>()
        let willAppearSubject = PassthroughSubject<Void, Never>()
        let willDisappearSubject = PassthroughSubject<Void, Never>()
    }

    enum LoadingState {
        case loading
        case finished
    }

    let loadingState = Observable<LoadingState>(.finished)
    let bag = DisposeBag()
    let lifeCycle = ViewLifeCycle()
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input : Input { get }
    var output : Output { get }
}
