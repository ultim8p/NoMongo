//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/27/23.
//

import Foundation
import MongoKitten

public extension DBCollectionable {
    
    @discardableResult
    func delete(in db: MongoDatabase) async throws -> DeleteReply {
        return try await Self.delete(in: db, id: _id)
    }
    
    static func delete(in db: MongoDatabase, id: ObjectId?) async throws -> DeleteReply {
        guard let id else { throw DBCollectionableError.missingField("_id") }
        return try await Self.deleteOne(in: db, where: ["_id": id])
    }
    
    @discardableResult
    static func deleteOne(in db: MongoDatabase, where document: Document) async throws
    -> DeleteReply {
        let coll = collection(in: db)
        return try await coll.deleteOne(where: document)
    }
}
