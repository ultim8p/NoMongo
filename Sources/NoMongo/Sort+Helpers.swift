//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/19/23.
//

import Foundation
import MongoKitten

public extension Sorting {
    
    static func dateCreated(_ order: Sorting.Order) -> Sorting {
        return Sorting([("dateCreated", order)])
    }
    
    static func dateUpdated(_ order: Sorting.Order) -> Sorting {
        return Sorting([("dateUpdated", order)])
    }
}
