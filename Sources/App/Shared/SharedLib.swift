import Foundation
import Fluent
import Vapor


 func getSettings(db: Database) async throws -> SettingsDTO {
    /* retrieve settings */
    var mySettingDTO: SettingsDTO = SettingsDTO()
    _ = try await Setting.query(on: db).all().compactMap{ setting in
        print("setting: \(setting)")
        
        /* ShowToolbar*/
        if setting.key == eSettings.ShowToolbar.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowToolbar = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowMessages*/
        if setting.key == eSettings.ShowMessages.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowMessages = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowApps*/
        if setting.key == eSettings.ShowApps.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowApps = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowNotifications*/
        if setting.key == eSettings.ShowNotifications.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowNotifications = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowUpdates*/
        if setting.key == eSettings.ShowUpdates.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowUpdates = Bool(setting.value.lowercased()) ?? false
        }
        
        return setting
    }
    return mySettingDTO
}
