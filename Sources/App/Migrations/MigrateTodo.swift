import Fluent

extension DataMigration.v1 {
    
    struct CreateTodo: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("todos")
                .id()
                .field("title", .string, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("todos").delete()
        }
    }
    
    struct SeedToDo: AsyncMigration {
        func prepare(on db: Database) async throws {
            
        }
        
        func revert(on database: Database) async throws {
            
        }
    }
}
