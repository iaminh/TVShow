//
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import Foundation
import Parse

// should be separated to files if necessarry

struct TVShow: PFObjectLoadable {
    let title: String
    let year: Int
    let sessions: Int
    
    init(title: String, year: Int, sessions: Int) {
        self.title = title
        self.year = year
        self.sessions = sessions
    }
    
    init?(from pfObject: PFObject) {
        guard let title = pfObject["title"] as? String,
            let year = pfObject["year"] as? Int,
            let sessions = pfObject["sessions"] as? Int
        else {
            return nil
        }
        
        self.title = title
        self.year = year
        self.sessions = sessions
    }

    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: TVShow.pfQueryName(), dictionary: [
            "title": title,
            "year": year,
            "sessions" : sessions
            ]
        )
        return pfObject
    }
    
    static func pfQueryName() -> String {
        return "TVSHow"
    }
}
