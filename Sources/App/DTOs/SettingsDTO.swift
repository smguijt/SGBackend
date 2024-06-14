import Fluent
import Vapor

struct SettingsDTO: Content {
    
    var ShowToolbar: Bool
    var ShowMessages: Bool
    var ShowApps: Bool
    var ShowNotifications : Bool
    var ShowUpdates: Bool
    
    init(ShowToolbar: Bool = false,
         ShowMessages: Bool = false,
         ShowApps: Bool = false,
         ShowNotifications: Bool = false,
         ShowUpdates: Bool = false) {
        
        self.ShowToolbar = ShowToolbar
        self.ShowMessages = ShowMessages
        self.ShowApps = ShowApps
        self.ShowNotifications = ShowNotifications
        self.ShowUpdates = ShowUpdates
    }
}
