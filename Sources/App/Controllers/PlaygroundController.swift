import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
        pg.get("item1", use: self.renderItem1)
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        req.logger.info("calling playground.index")
        let mySettingsDTO = try await getSettings(db: req.db)
        return try await req.view.render("playgroundIndex", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func renderItem1(req: Request) async throws -> View {
        req.logger.info("calling playground.item1")
        return try await req.view.render("playgroundItem1")
    }
    
    private func getSettings(db: Database) async throws -> SettingsDTO {
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
            if setting.key == eSettings.ShowToolbar.rawValue {
                print("value: \(String(describing: setting.value.lowercased()))")
                mySettingDTO.ShowToolbar = Bool(setting.value.lowercased()) ?? false
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
    
   
}
