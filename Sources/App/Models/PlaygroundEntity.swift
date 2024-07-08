import Foundation
import Fluent

final class PlaygroundEntity: Model, @unchecked Sendable {
    static let schema = "playground_entity"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "userId")
    var userId: UUID?
    
    @Field(key: "entityCode")
    var entityCode: String?

    @Field(key: "entityDescription")
    var entityDescription: String?
    
    @Field(key: "lastUpdated")
    var lastUpdated: Date?
    
    @Field(key: "active")
    var active: Bool?
    
    @Field(key: "playgroundId")
    var playgroundId: UUID?
    
    init() { }
    
    init(id: UUID?, entityCode: String?, entityDescription: String?, active: Bool? = false, userId: UUID?, playgroundId: UUID?) {
        self.id = id
        self.entityCode = entityCode
        self.entityDescription = entityDescription
        self.lastUpdated = Date()
        self.active = active
        self.userId = userId
        self.playgroundId = playgroundId
    }
    

}


