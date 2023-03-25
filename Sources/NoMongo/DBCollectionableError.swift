//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/16/23.
//

import Foundation

public enum DBCollectionableError: Error {
    
    case missingField(_ field: String)
    
    case objectNotFound(_ name: String)
    
    case noPermission
}
