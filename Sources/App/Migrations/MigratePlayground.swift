import Foundation
import Fluent

extension DataMigration.v1 {
    struct CreatePlayground: AsyncMigration {
        
        func revert(on db: any FluentKit.Database) async throws {
            try await db.schema("playground_additional_data").delete()
            try await db.schema("playground_entity").delete()
            try await db.schema("playground").delete()
        }
        
        func prepare(on db: any FluentKit.Database) async throws {
            try await db.schema("playground")
                .id()
                .field("userId", .uuid)
                .field("lastUpdated", .datetime)
                .field("title", .string)
                .field("description", .string)
                .field("subText", .string)
                .field("active", .bool)
                .create()
            
            try await db.schema("playground_entity")
                .id()
                .field("userId", .uuid)
                .field("lastUpdated", .datetime)
                .field("active", .bool)
                .field("playgroundId", .uuid)
                .field("entityCode", .string)
                .field("entityDescription", .string)
                .create()
            
            try await db.schema("playground_additional_data")
                .id()
                .field("userId", .uuid)
                .field("lastUpdated", .datetime)
                .field("active", .bool)
                .field("playgroundId", .uuid)
                .field("text1", .string)
                .field("text2", .string)
                .field("text3", .string)
                .field("text4", .string)
                .field("text5", .string)
                .field("text6", .string)
                .field("text7", .string)
                .field("text8", .string)
                .field("text9", .string)
                .field("text10", .string)
                .field("num1", .double)
                .field("num2", .double)
                .field("num3", .double)
                .field("num4", .double)
                .field("num5", .double)
                .field("date1", .datetime)
                .field("date2", .datetime)
                .field("date3", .datetime)
                .field("date4", .datetime)
                .field("date5", .datetime)
                .create()
        }
        
    }
    
    struct SeedPlayground: AsyncMigration {
        
        func revert(on db: any FluentKit.Database) async throws {
            try await PlaygroundEntity.query(on: db).delete()
            try await PlaygroundAdditionalData.query(on: db).delete()
            try await Playground.query(on: db).delete()
        }
        
        func prepare(on db: any FluentKit.Database) async throws {
            
        }
        
    }
}
