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
    var UseOAUTH02: Bool
    var ClientId: String
    var ClientSecret: String
    
    init(ShowToolbar: Bool = false,
         ShowMessages: Bool = false,
         ShowApps: Bool = false,
         ShowNotifications: Bool = false,
         ShowUpdates: Bool = false,
         ShowUserBox: Bool = false, 
         userId: UUID? = nil,
         UseOAUTH02: Bool = false,
         ClientId: String = "",
         ClientSecret: String = "") {
        
        self.ShowToolbar = ShowToolbar
        self.ShowMessages = ShowMessages
        self.ShowApps = ShowApps
        self.ShowNotifications = ShowNotifications
        self.ShowUpdates = ShowUpdates
        self.ShowUserBox = ShowUserBox
        self.userId = userId
        self.UseOAUTH02 = UseOAUTH02
        self.ClientId = ClientId
        self.ClientSecret = ClientSecret
    }
}
