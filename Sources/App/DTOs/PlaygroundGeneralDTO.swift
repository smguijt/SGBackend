import Fluent
import Vapor

struct PlaygroundGeneralDTO: Content {
    var id: String
    var title: String
    var description: String
    var subText: String
    var lastUpdated: Date
    var active: Bool

    init() {
        self.id = UUID().uuidString
        self.active = false
        self.title = ""
        self.description = ""
        self.subText = ""
        self.lastUpdated = Date()
    }

    init(id: String, 
         title: String, 
         description: String, 
         subText: String, 
         lastUpdated: Date, 
         active: Bool) {
            
        self.id = id
        self.title = title
        self.description = description
        self.subText = subText
        self.lastUpdated = lastUpdated
        self.active = active
    }

}