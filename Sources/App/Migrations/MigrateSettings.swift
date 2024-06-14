import Fluent

extension DataMigration.v1 {
    
    struct CreateSettings: AsyncMigration {
        func prepare(on db: Database) async throws {
            try await db.schema("settings")
                .id()
                .field("key", .string, .required)
                .field("value", .string, .required)
                .create()
        }
        
        func revert(on db: Database) async throws {
            try await db.schema("settings").delete()
        }
    }
    
    struct SeedSettings: AsyncMigration {
        func prepare(on db: Database) async throws {
            
            /* create entry */
            let settingShowToolbar = Setting(key: eSettings.ShowToolbar.rawValue, value: "true")
            try await settingShowToolbar.create(on: db)
            
            /* create entry */
            let settingShowMessages = Setting(key: eSettings.ShowMessages.rawValue, value: "true")
            try await settingShowMessages.create(on: db)
            
            /* create entry */
            let settingShowApps = Setting(key: eSettings.ShowApps.rawValue, value: "true")
           try await settingShowApps.create(on: db)
            
            /* create entry */
           let settingShowNotifications = Setting(key: eSettings.ShowNotifications.rawValue, value: "true")
           try await settingShowNotifications.create(on: db)
            
            /* create entry */
           let settingShowUpdates = Setting(key: eSettings.ShowUpdates.rawValue, value: "true")
           try await settingShowUpdates.create(on: db)
        }
        
        func revert(on db: Database) async throws {
            try await Setting.query(on: db).delete()
        }
    }
}
