//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/29/23.
//

import Foundation
import Vapor
import MongoKitten

public extension DBCollectionable {
    
    static func inc(in db: MongoDatabase, updates: [String: Int], query: Document)
    async throws {
        let updates: Document = [
            "$inc": updates,
            "$set": ["dateUpdated": Date()]
        ]
        return try await Self.upsert(in: db, updates: updates, query: query)
    }
    
    static func inc(in db: MongoDatabase, updates: [String: Double], query: Document)
    async throws {
        let updates: Document = [
            "$inc": updates,
            "$set": ["dateUpdated": Date()]
        ]
        return try await Self.upsert(in: db, updates: updates, query: query)
    }
}
