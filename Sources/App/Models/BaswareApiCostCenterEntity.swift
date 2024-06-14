import Foundation
import Fluent

final class BaswareCostCenterEntity: Model, @unchecked Sendable {
    
    static let schema = "basware_cost_centers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "externalCode")
    var externalCode: String

    @Field(key: "costCenterCode")
    var costCenterCode: String
    
    //@Field(key: "costCenterName")
    //var costCenterName: [BaswareCostCenterTranslation]?
    
    @Field(key: "text1")
    var text1: String?
    
    @Field(key: "text2")
    var text2: String?
    
    @Field(key: "text3")
    var text3: String?
    
    @Field(key: "text4")
    var text4: String?
    
    @Field(key: "text5")
    var text5: String?
    
    @Field(key: "text6")
    var text6: String?
    
    @Field(key: "text7")
    var text7: String?
    
    @Field(key: "text8")
    var text8: String?
    
    @Field(key: "text9")
    var text9: String?
    
    @Field(key: "text10")
    var text10: String?
    
    @Field(key: "int1")
    var int1: Int?
    
    @Field(key: "int2")
    var int2: Int?
    
    @Field(key: "int3")
    var int3: Int?
    
    @Field(key: "int4")
    var int4: Int?
    
    @Field(key: "int5")
    var int5: Int?
    
    @Field(key: "date1")
    var date1: Date?
    
    @Field(key: "date2")
    var date2: Date?
    
    @Field(key: "date3")
    var date3: Date?
    
    @Field(key: "date4")
    var date4: Date?
    
    @Field(key: "date5")
    var date5: Date?
    
    //@Field(key: "companies")
    //var companies: [BaswareCostCenterCompanyEntity]?
    
    @Field(key: "userId")
    var userId: UUID?
    
    init(id: UUID? = nil, externalCode: String, costCenterCode: String, 
         //costCenterName: [BaswareCostCenterTranslation]? = nil,
         text1: String? = nil, text2: String? = nil, text3: String? = nil, text4: String? = nil, text5: String? = nil, text6: String? = nil, text7: String? = nil, text8: String? = nil, text9: String? = nil, text10: String? = nil, int1: Int? = nil, int2: Int? = nil, int3: Int? = nil, int4: Int? = nil, int5: Int? = nil, date1: Date? = nil, date2: Date? = nil, date3: Date? = nil, date4: Date? = nil, date5: Date? = nil, //companies: [BaswareCostCenterCompanyEntity]? = nil,
         userId: UUID? = nil) {
        
        self.id = id
        self.externalCode = externalCode
        self.costCenterCode = costCenterCode
        //self.costCenterName = costCenterName
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
        self.text5 = text5
        self.text6 = text6
        self.text7 = text7
        self.text8 = text8
        self.text9 = text9
        self.text10 = text10
        self.int1 = int1
        self.int2 = int2
        self.int3 = int3
        self.int4 = int4
        self.int5 = int5
        self.date1 = date1
        self.date2 = date2
        self.date3 = date3
        self.date4 = date4
        self.date5 = date5
        //self.companies = companies
        self.userId = userId
    }
    
    init() {
        
    }
    
}

