import Foundation
import Fluent
import Vapor


 func getSettings(req: Request) async throws -> SettingsDTO {
    /* retrieve settings */
    var mySettingDTO: SettingsDTO = SettingsDTO()
    _ = try await Setting.query(on: req.db).all().compactMap{ setting in
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

        /* ShowUserBox*/
        if setting.key == eSettings.ShowUserBox.rawValue {
            print("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowUserBox = Bool(setting.value.lowercased()) ?? false
        }
        
       
    }
    return mySettingDTO
}

 func getUserSettings(req: Request, userId: UUID) async throws -> SettingsDTO {
     
    var myUserSettingDTO: UserSettingsDTO = UserSettingsDTO(userId: userId)

     _ = try await UserSettings
            .query(on: req.db)
            .filter(\.$userId == userId)
            .all()
            .compactMap { setting in
                print("userSetting: \(setting)")  

                /* ShowMessages*/
                if setting.key == eSettings.ShowMessages.rawValue {
                    print("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowMessages = Bool(setting.value.lowercased()) ?? false
                }  

                /* ShowApps*/
                if setting.key == eSettings.ShowApps.rawValue {
                    print("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowApps = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ShowNotifications*/
                if setting.key == eSettings.ShowNotifications.rawValue {
                    print("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowNotifications = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ShowUpdates*/
                if setting.key == eSettings.ShowUpdates.rawValue {
                    print("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowUpdates = Bool(setting.value.lowercased()) ?? false
                }

                return setting
            }
     
    let mySystemSettings: SettingsDTO = try await getSettings(req: req)

    let mySettingDTO: SettingsDTO = SettingsDTO(ShowToolbar: mySystemSettings.ShowToolbar, 
                                                ShowMessages: myUserSettingDTO.ShowMessages, 
                                                ShowApps: myUserSettingDTO.ShowApps, 
                                                ShowNotifications: myUserSettingDTO.ShowNotifications, 
                                                ShowUpdates: myUserSettingDTO.ShowUpdates, 
                                                ShowUserBox: mySystemSettings.ShowUserBox,
                                                userId: myUserSettingDTO.userId)
    return mySettingDTO
 }