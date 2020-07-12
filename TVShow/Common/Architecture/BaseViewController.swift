//
//  BaseViewController.swift
//

import UIKit
import ReactiveKit
import Bond

class BaseViewController: UIViewController {
    var showLoading = Observable<Bool>(false)

    override func viewDidLoad() {
        super.viewDidLoad()

        showLoading
            .receive(on: DispatchQueue.main)
            .observeNext { [weak self] (loading) in
                if loading {
                    self?.showActivityIndicator()
                } else {
                    self?.hideActivityIndicator()
                }
            }.dispose(in: bag)

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }

    func bindScrollViewToKeyboardNotifications(scrollView: UIScrollView) {
        NotificationCenter.default.reactive
            .notification(name: UIResponder.keyboardWillShowNotification)
            .receive(on: DispatchQueue.main)
            .observeNext { [weak self, weak scrollView] (notification) in
                guard let self = self, let userInfo = notification.userInfo else { return }
                UIView.animate(withDuration: 0.3) { [weak scrollView] in
                    var keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
                    keyboardFrame = self.view.convert(keyboardFrame, from: nil)

                    var contentInset = scrollView?.contentInset ?? .zero
                    contentInset.bottom = keyboardFrame.size.height + 44.0 // suggestion bar
                    scrollView?.contentInset = contentInset
                }
            }.dispose(in: bag)

        NotificationCenter.default.reactive
            .notification(name: UIResponder.keyboardWillHideNotification)
            .receive(on: DispatchQueue.main)
            .observeNext { [weak scrollView] (_) in
                UIView.animate(withDuration: 0.3) { [weak scrollView] in
                    scrollView?.contentInset = .zero
                }
            }.dispose(in: bag)
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ReactiveExtensions where Base: UIViewController {
    var hideBackButton: Bond<Bool> {
        return bond { controller, hideBackButton in
            controller.navigationItem.hidesBackButton = hideBackButton
        }
    }
    var navigationTitle: Bond<String?> {
        return bond { controller, string in
            guard let string = string else {
                return
            }
            controller.navigationItem.title = string
        }
    }

    var leftBarButtonItem: Bond<UIBarButtonItem?> {
        return bond { controller, item in
            guard let item = item else {
                return
            }
            controller.navigationItem.leftBarButtonItem = item
        }
    }

    var rightBarButtonItem: Bond<UIBarButtonItem?> {
        return bond { controller, item in
            guard let item = item else {
                return
            }
            controller.navigationItem.rightBarButtonItem = item
        }
    }
}

private let overlayViewTag = 999
private let activityIndicatorTag = 1_000

extension UIViewController {
    public func showActivityIndicator() {
        setActivityIndicator()
    }

    public func hideActivityIndicator() {
        removeActivityIndicator()
    }

    private func setActivityIndicator() {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        guard let parentViewForOverlay = view else { return }

        //configure overlay
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = UIColor.white
        overlay.alpha = 0.6
        overlay.tag = overlayViewTag

        //configure activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = activityIndicatorTag
        activityIndicator.color = .black

        //add subviews
        overlay.addSubview(activityIndicator)
        parentViewForOverlay.addSubview(overlay)

        //add overlay constraints
        overlay.heightAnchor.constraint(equalTo: parentViewForOverlay.heightAnchor).isActive = true
        overlay.widthAnchor.constraint(equalTo: parentViewForOverlay.widthAnchor).isActive = true

        //add indicator constraints
        activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true

        //animate indicator
        activityIndicator.startAnimating()
    }

    private func removeActivityIndicator() {
        let activityIndicator = getActivityIndicator()

        if let overlayView = getOverlayView() {
            let animations = {
                overlayView.alpha = 0.0
                activityIndicator?.stopAnimating()
            }
            UIView.animate(withDuration: 0.2, animations: animations) { _ in
                activityIndicator?.removeFromSuperview()
                overlayView.removeFromSuperview()
            }
        }
    }

    private func isDisplayingActivityIndicatorOverlay() -> Bool {
        if getActivityIndicator() != nil && getOverlayView() != nil {
            return true
        }
        return false
    }

    private func getActivityIndicator() -> UIActivityIndicatorView? {
        return (view.viewWithTag(activityIndicatorTag)) as? UIActivityIndicatorView
    }

    private func getOverlayView() -> UIView? {
        return view.viewWithTag(overlayViewTag)
    }
}
