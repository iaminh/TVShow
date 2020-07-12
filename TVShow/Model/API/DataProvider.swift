//
//  API.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import Foundation
import ReactiveKit
import Parse

protocol PFObjectLoadable {
    init?(from pfObject: PFObject)
    func toPFObject() -> PFObject
    static func pfQueryName() -> String
}

class DataProvider {
    enum ProviderError: Error {
        case fail
    }
    func saveObject<T: PFObjectLoadable>(object: T, completion: @escaping (Bool) -> Void) {
        let pfObject = object.toPFObject()
        
        pfObject.saveInBackground { success, error in
            completion(success)
        }
    }
    
    func getObjects<T: PFObjectLoadable>(completion: @escaping (Result<[T], ProviderError>) -> Void) {
        let query = PFQuery(className: T.pfQueryName())
       
        query.findObjectsInBackground { objects, error in
            guard let found = objects else {
                completion(.failure(.fail))
                return
            }
            
            completion(.success(found.compactMap { T(from: $0) }))
        }
    }
}
