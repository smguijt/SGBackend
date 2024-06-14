import Foundation
import Fluent

final class BaswareCostCenterCompanyEntity: Model, @unchecked Sendable {
    
    static let schema = "basware_cost_center_companies"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "companyCode")
    var companyCode: String
    
    @Field(key: "active")
    var active: Bool
    
    @Field(key: "createdAt")
    var createdAt: Date
    
    @Field(key: "updatedAt")
    var updatedAt: Date
    
    @Field(key: "costCenterId")
    var costCenterId: UUID
    
    @Field(key: "userId")
    var userId: UUID?
    
    init(id: UUID? = nil, companyCode: String, active: Bool, createdAt: Date, updatedAt: Date, costCenterId: UUID, userId: UUID? = nil) {
        self.id = id
        self.companyCode = companyCode
        self.active = active
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.costCenterId = costCenterId
        self.userId = userId
    }
    
    init() {
        
    }
    
}

