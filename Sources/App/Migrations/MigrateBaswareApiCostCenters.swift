import Fluent

extension DataMigration.v1 {
    
    struct CreateCostCenters: AsyncMigration {
        
        func prepare(on db: Database) async throws {
            try await db.schema("basware_cost_centers")
                .id()
                .field("externalCode", .string, .required)
                .field("costCenterCode", .string, .required)
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
                .field("createdAt", .datetime)
                .field("updatedAt", .datetime)
                .field("userId", .uuid)
                .create()
            
            try await db.schema("basware_cost_center_companies")
                .id()
                .field("companyCode", .string, .required)
                .field("costCenterId", .uuid, .required)
                .field("active", .bool)
                .field("createdAt", .datetime)
                .field("updatedAt", .datetime)
                .field("userId", .uuid)
                .create()
            
            try await db.schema("basware_cost_center_translation")
                .id()
                .field("translation", .string, .required)
                .field("costCenterId", .uuid, .required)
                .field("language", .string, .required)
                .field("createdAt", .datetime)
                .field("updatedAt", .datetime)
                .field("userId", .uuid)
                .create()
        }
        
        func revert(on db: Database) async throws {
            try await db.schema("basware_cost_center_companies").delete()
            try await db.schema("basware_cost_center_translation").delete()
            try await db.schema("basware_cost_centers").delete()
        }
    }
    
    struct SeedCostCenters: AsyncMigration {
        func revert(on db: any FluentKit.Database) async throws {
            try await BaswareCostCenterTranslation.query(on: db).delete()
            try await BaswareCostCenterCompanyEntity.query(on: db).delete()
            try await BaswareCostCenterEntity.query(on: db).delete()
        }
        
        func prepare(on db: Database) async throws {
            
        }
    }
}
