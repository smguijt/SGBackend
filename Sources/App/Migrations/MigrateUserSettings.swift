import Fluent
import Foundation

extension DataMigration.v1 {
    
    struct CreateUserSettings: AsyncMigration {
        func prepare(on db: Database) async throws {
            try await db.schema("user_settings")
                .id()
                .field("key", .string, .required)
                .field("value", .string, .required)
                .field("userId", .uuid, .required)
                .create()
        }
        
        func revert(on db: Database) async throws {
            try await db.schema("settings").delete()
        }
    }
    
    struct SeedUserSettings: AsyncMigration {
        func prepare(on db: Database) async throws {
            
            /* add dummy user */
            let userIdString =  "ea21f445-ddd4-40ed-86dd-a629f771c5f4"
            let userId : UUID = UUID(uuidString: userIdString) ?? UUID()

            /* create entry */
            let settingShowMessages = UserSettings(key: eSettings.ShowMessages.rawValue, value: "true", userId: userId)
            try await settingShowMessages.create(on: db)
            
            /* create entry */
            let settingShowApps = UserSettings(key: eSettings.ShowApps.rawValue, value: "true", userId: userId)
           try await settingShowApps.create(on: db)
            
            /* create entry */
           let settingShowNotifications = UserSettings(key: eSettings.ShowNotifications.rawValue, value: "true", userId: userId)
           try await settingShowNotifications.create(on: db)
            
            /* create entry */
           let settingShowUpdates = UserSettings(key: eSettings.ShowUpdates.rawValue, value: "true", userId: userId)
           try await settingShowUpdates.create(on: db)

        }
        
        func revert(on db: Database) async throws {
            try await UserSettings.query(on: db).delete()
        }
    }
}
