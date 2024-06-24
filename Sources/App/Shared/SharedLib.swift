import Foundation
import Fluent
import Vapor

 func getSettings(req: Request) async throws -> SettingsDTO {
       
     if req.session.data["sgsoftware_systemuser"] == nil {
         return try await getSystemSettings(req: req)
     }
     return try await getUserSettings(req: req, userId: UUID(req.session.data["sgsoftware_systemuser"] ?? "") ?? UUID())
 }


 func getSystemSettings(req: Request) async throws -> SettingsDTO {
    /* retrieve settings */
    var mySettingDTO: SettingsDTO = SettingsDTO()
    _ = try await Setting.query(on: req.db).all().compactMap{ setting in
        //req.logger.info("setting: \(setting)")
        
        
        /* ShowToolbar*/
        if setting.key == eSettings.ShowToolbar.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowToolbar = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowMessages*/
        if setting.key == eSettings.ShowMessages.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowMessages = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowApps*/
        if setting.key == eSettings.ShowApps.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowApps = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowNotifications*/
        if setting.key == eSettings.ShowNotifications.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowNotifications = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowUpdates*/
        if setting.key == eSettings.ShowUpdates.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowUpdates = Bool(setting.value.lowercased()) ?? false
        }

        /* ShowUserBox*/
        if setting.key == eSettings.ShowUserBox.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.ShowUserBox = Bool(setting.value.lowercased()) ?? false
        }
        
        /* ShowUseOAUTH02 */
        if setting.key == eSettings.UseOAUTH02.rawValue {
            //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
            mySettingDTO.UseOAUTH02 = Bool(setting.value.lowercased()) ?? false
        }
    }
    
     // load userId from session
    mySettingDTO.userId = UUID(req.session.data["sgsoftware_systemuser"] ?? "")

    //req.logger.info("geSystemSettings data parsed: \(mySettingDTO)")
    return mySettingDTO
}

 func getUserSettings(req: Request, userId: UUID) async throws -> SettingsDTO {
     
    var myUserSettingDTO: UserSettingsDTO = UserSettingsDTO(userId: userId)

     _ = try await UserSettings
            .query(on: req.db)
            .filter(\.$userId == userId)
            .all()
            .compactMap { setting in
                //req.logger.info("userSetting: \(setting)")

                /* ShowMessages*/
                if setting.key == eSettings.ShowMessages.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowMessages = Bool(setting.value.lowercased()) ?? false
                }  

                /* ShowApps*/
                if setting.key == eSettings.ShowApps.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowApps = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ShowNotifications*/
                if setting.key == eSettings.ShowNotifications.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowNotifications = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ShowUpdates*/
                if setting.key == eSettings.ShowUpdates.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.ShowUpdates = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ShowUseOAUTH02 */
                if setting.key == eSettings.UseOAUTH02.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value.lowercased()))")
                    myUserSettingDTO.UseOAUTH02 = Bool(setting.value.lowercased()) ?? false
                }
                
                /* ClientId */
                if setting.key == eSettings.ClientId.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value))")
                    myUserSettingDTO.ClientId = String(setting.value)
                }
                
                /* ClientSecret */
                if setting.key == eSettings.ClientSecret.rawValue {
                    //req.logger.info("value: \(String(describing: setting.value))")
                    myUserSettingDTO.ClientSecret = String(setting.value)
                }

                return myUserSettingDTO
            }

    //req.logger.info("geUserSettings data parsed: \(_tmpSettings)")
    //req.logger.info("load system settings")
    let mySystemSettings: SettingsDTO = try await getSystemSettings(req: req)
    
    //req.logger.info("update settings output")
    let mySettingDTO: SettingsDTO = SettingsDTO(ShowToolbar: mySystemSettings.ShowToolbar,
                                                ShowMessages: myUserSettingDTO.ShowMessages, 
                                                ShowApps: myUserSettingDTO.ShowApps, 
                                                ShowNotifications: myUserSettingDTO.ShowNotifications, 
                                                ShowUpdates: myUserSettingDTO.ShowUpdates, 
                                                ShowUserBox: mySystemSettings.ShowUserBox,
                                                userId: mySystemSettings.userId,
                                                UseOAUTH02: mySystemSettings.UseOAUTH02,
                                                ClientId: myUserSettingDTO.ClientId,
                                                ClientSecret: myUserSettingDTO.ClientSecret)
    //req.logger.info("updated userSettings data parsed: \(mySettingDTO)")
    return mySettingDTO
 }
