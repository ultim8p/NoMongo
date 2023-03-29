//
//  Collectionable+Save.collectionName.swift
//  
//
//  Created by Guerson Perez on 3/15/23.
//

import Foundation
import MongoKitten

public extension DBCollectionable {
    
    func save(in db: MongoDatabase) async throws {
        let collection = collection(in: db)
        guard let id = _id else { throw DBCollectionableError.missingField("_id") }
        try await collection.upsertEncoded(self, where: "_id" == id)
    }
    
    static func upsert(in db: MongoDatabase, updates: Document, query: Document) async throws {
        let coll = collection(in: db)
        try await coll.upsert(updates, where: query)
    }
}
