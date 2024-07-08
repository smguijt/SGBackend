import Fluent
import Vapor

struct ListContentDTO: Content {
    
    let id: String?
    let title: String?
    let description: String?
    let subText: String?
    let link: String?
    let active: Bool?
    let lastUpdated: Date?
    
    init(id: String?, title: String?, description: String?, link: String?, active: Bool?, subText: String?, lastUpdated: Date?) {
        self.id = id
        self.title = title
        self.description = description
        self.link = link ?? "#"
        self.active = active ?? false
        self.subText = subText
        self.lastUpdated = lastUpdated
    }
}
