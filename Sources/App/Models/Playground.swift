import Foundation
import Fluent

final class Playground: Model, @unchecked Sendable {
    static let schema = "playground"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "userId")
    var userId: UUID?
    
    @Field(key: "title")
    var title: String?

    @Field(key: "description")
    var description: String?
    
    @Field(key: "subText")
    var subText: String?
    
    @Field(key: "lastUpdated")
    var lastUpdated: Date?
    
    @Field(key: "active")
    var active: Bool?
    
    init() { }
    
    init(id: UUID?, title: String?, description: String?, subText: String?, active: Bool? = false) {
        self.id = id
        self.title = title
        self.description = description
        self.subText = subText
        self.lastUpdated = Date()
        self.active = active
    }
    

}

