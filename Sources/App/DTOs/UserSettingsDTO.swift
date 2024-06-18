import Fluent
import Vapor

struct UserSettingsDTO: Content {
    
    var ShowMessages: Bool
    var ShowApps: Bool
    var ShowNotifications : Bool
    var ShowUpdates: Bool
    var userId: UUID

    init(userId: UUID, 
         ShowMessages: Bool = false,
         ShowApps: Bool = false,
         ShowNotifications: Bool = false,
         ShowUpdates: Bool = false) {

        self.ShowMessages = ShowMessages
        self.ShowApps = ShowApps
        self.ShowNotifications = ShowNotifications
        self.ShowUpdates = ShowUpdates
        self.userId = userId
    }    
  
}