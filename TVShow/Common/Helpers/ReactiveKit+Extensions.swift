//
//  ReactiveKit+Extensions.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

extension Property {
    public func unwrap<T>() -> Signal<T, Never> where Element == T? {
        return self.filter {
            $0 != nil
        }.map {
            $0!
        }
    }

    public func unwrap<A, B>() -> Signal<(A, B), Never> where Element == (A?, B?) {
        return self.filter {
            ($0.0 != nil && $0.1 != nil)
        }.map {
            ($0.0!, $0.1!)
        }
    }

    public func unwrap<A, B, C>() -> Signal<(A, B, C), Never> where Element == (A?, B?, C?) {
        return self.filter {
            ($0.0 != nil && $0.1 != nil && $0.2 != nil)
        }.map {
            ($0.0!, $0.1!, $0.2!)
        }
    }

    public func unwrap<A, B, C>() -> Signal<(A, B, C), Never> where Element == (A?, B?, C) {
        return self.filter {
            ($0.0 != nil && $0.1 != nil)
            }.map {
                ($0.0!, $0.1!, $0.2)
        }
    }

    public func mapTo<T>(_ value: T) -> Signal<T, Never> {
        return self.map { _ -> T in
            return value
        }
    }

    public func toVoid() -> Signal<Void, Error> {
        return self.map { _ -> Void in
            return ()
        }
    }
}
