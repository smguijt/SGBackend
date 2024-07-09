import Foundation
import Fluent

final class PlaygroundAdditionalData: Model, @unchecked Sendable {
    static let schema = "playground_additional_data"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "userId")
    var userId: UUID?
    
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
    
    @Field(key: "num1")
    var num1: Double?
    
    @Field(key: "num2")
    var num2: Double?
    
    @Field(key: "num3")
    var num3: Double?
    
    @Field(key: "num4")
    var num4: Double?
    
    @Field(key: "num5")
    var num5: Double?
    
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
    
    @Field(key: "lastUpdated")
    var lastUpdated: Date?
    
    @Field(key: "active")
    var active: Bool?
    
    @Field(key: "playgroundId")
    var playgroundId: UUID?
    
    init() { }

    init(id: UUID?, 
         text1: String?,
         num1: Double?,
         date1: Date?,
         active: Bool?,
         userId: UUID?,
         playgroundId: UUID?) {

        self.id = id
        self.text1 = text1    
        self.num1 = num1
        self.date1 = date1
        self.lastUpdated = Date()
        self.active = active  ?? false
        self.playgroundId = playgroundId
        self.userId = userId
    }
    
    init(id: UUID?, 
         text1: String?, text2: String?, 
         text3: String?, text4: String?,
         text5: String?, text6: String?,
         text7: String?, text8: String?,
         text9: String?, text10: String?,
         num1: Double?, num2: Double?,
         num3: Double?, num4: Double?,
         num5: Double?,
         date1: Date?, date2: Date?,
         date3: Date?, date4: Date?,
         date5: Date?,
         active: Bool?, 
         userId: UUID?,
         playgroundId: UUID?) {
        
        self.id = id
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
        self.num1 = num1 ?? 0
        self.num2 = num2 ?? 0
        self.num3 = num3 ?? 0
        self.num4 = num4 ?? 0
        self.num5 = num5 ?? 0
        self.date1 = date1
        self.date2 = date2
        self.date3 = date3
        self.date4 = date4
        self.date5 = date5
        self.lastUpdated = Date()
        self.active = active  ?? false
        self.playgroundId = playgroundId
        self.userId = userId
    }
    
    func toPlaygroundAdditionalDataDTO() -> PlaygroundAdditionalDataDTO {
        .init(
            id: self.id?.uuidString ?? "",
            active: self.$active.value! ?? false,
            lastUpdated: self.$lastUpdated.value! ?? Date(),
            text_1: self.$text1.value!,
            text_2: self.$text2.value!,
            text_3: self.$text3.value!,
            text_4: self.$text4.value!,
            text_5: self.$text5.value!,
            text_6: self.$text6.value!,
            text_7: self.$text7.value!,
            text_8: self.$text8.value!,
            text_9: self.$text9.value!,
            text_10: self.$text10.value!,
            num_1: self.$num1.value! ?? 0,
            num_2: self.$num2.value! ?? 0,
            num_3: self.$num3.value! ?? 0,
            num_4: self.$num4.value! ?? 0,
            num_5: self.$num5.value! ?? 0,
            date_1: self.$date1.value!,
            date_2: self.$date2.value!,
            date_3: self.$date3.value!,
            date_4: self.$date4.value!,
            date_5: self.$date5.value!
        )
    }
}


