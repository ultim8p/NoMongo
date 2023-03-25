//
//  DatabaseCollectionable.swift
//  
//
//  Created by Guerson Perez on 3/15/23.
//

import MongoKitten

public protocol DBCollectionable: Codable {
    
    var _id: ObjectId? { get set }
    
    static var collectionName: String { get }
}

public extension DBCollectionable {
    
    static var collectionName: String {
        var collName = String(describing: self).lowercased()
        if collName.last != "s" {
            collName += "s"
        }
        return collName
    }
    
    static func collection(in db: MongoDatabase) -> MongoCollection {
        return db[Self.collectionName]
    }
    
    func collection(in db: MongoDatabase) -> MongoCollection {
        return db[type(of: self).collectionName]
    }
}

public extension DBCollectionable {
    
    static var objectName: String {
        return String(describing: self)
    }
}

public extension DBCollectionable {
    
    func ensureId(equals: ObjectId?) throws {
        guard let equals, let _id, equals == _id
        else { throw DBCollectionableError.noPermission }
        
    }
}
