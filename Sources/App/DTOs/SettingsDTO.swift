import Fluent
import Vapor

struct SettingsDTO: Content {
    
    var ShowToolbar: Bool
    var ShowMessages: Bool
    var ShowApps: Bool
    var ShowNotifications : Bool
    var ShowUpdates: Bool
    var ShowUserBox: Bool
    var userId: UUID?
    
    init(ShowToolbar: Bool = false,
         ShowMessages: Bool = false,
         ShowApps: Bool = false,
         ShowNotifications: Bool = false,
         ShowUpdates: Bool = false,
         ShowUserBox: Bool = false, 
         userId: UUID? = nil) {
        
        self.ShowToolbar = ShowToolbar
        self.ShowMessages = ShowMessages
        self.ShowApps = ShowApps
        self.ShowNotifications = ShowNotifications
        self.ShowUpdates = ShowUpdates
        self.ShowUserBox = ShowUserBox
        self.userId = userId
    }
}
