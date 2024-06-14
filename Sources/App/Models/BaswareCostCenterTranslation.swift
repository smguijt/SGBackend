import Foundation
import Fluent

final class BaswareCostCenterTranslation: Model, @unchecked Sendable {

    static let schema = "basware_cost_center_translation"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "translation")
    var translation: String
    
    @Field(key: "language")
    var language: String
    
    @Field(key: "createdAt")
    var createdAt: Date?
    
    @Field(key: "updatedAt")
    var updatedAt: Date?
    
    @Field(key: "costCenterId")
    var costCenterId: UUID
    
    @Field(key: "userId")
    var userId: UUID?
    
    init(id: UUID? = nil, 
         translation: String,
         language: String,
         createdAt: Date? = Date(),
         updatedAt: Date? = Date(),
         costCenterId: UUID,
         userId: UUID? = nil) {
        
        self.id = id
        self.translation = translation
        self.language = language
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.costCenterId = costCenterId
        self.userId = userId
    }
    
    init() {
        
    }
}

