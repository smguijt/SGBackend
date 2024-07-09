
import Fluent
import Vapor

struct PlaygroundAdditionalDataDTO: Content {
    var id: String
    var lastUpdated: Date
    var active: Bool
    let text_1: String?
    let text_2: String?
    let text_3: String?
    let text_4: String?
    let text_5: String?
    let text_6: String?
    let text_7: String?
    let text_8: String?
    let text_9: String?
    let text_10: String?
    let date_1: Date?
    let date_2: Date?
    let date_3: Date?
    let date_4: Date?
    let date_5: Date?
    let num_1: Double?
    let num_2: Double?
    let num_3: Double?
    let num_4: Double?
    let num_5: Double?
    
    init() {
        self.id = UUID().uuidString
        self.active = false
        self.lastUpdated = Date()
        self.text_1 = ""
        self.text_2 = ""
        self.text_3 = ""
        self.text_4 = ""
        self.text_5 = ""
        self.text_6 = ""
        self.text_7 = ""
        self.text_8 = ""
        self.text_9 = ""
        self.text_10 = ""
        self.num_1 = 0
        self.num_2 = 0
        self.num_3 = 0
        self.num_4 = 0
        self.num_5 = 0
        self.date_1 = nil
        self.date_2 = nil
        self.date_3 = nil
        self.date_4 = nil
        self.date_5 = nil
    }
    
    init(id: String,
         active: Bool?,
         lastUpdated: Date?,
         text_1: String?,
         text_2: String?,
         text_3: String?,
         text_4: String?,
         text_5: String?,
         text_6: String?,
         text_7: String?,
         text_8: String?,
         text_9: String?,
         text_10: String?,
         num_1: Double?,
         num_2: Double?,
         num_3: Double?,
         num_4: Double?,
         num_5: Double?,
         date_1: Date?,
         date_2: Date?,
         date_3: Date?,
         date_4: Date?,
         date_5: Date?
    ) {
        self.id = id
        self.active = active ?? false
        self.lastUpdated = lastUpdated ?? Date()
        self.date_1 = date_1
        self.date_2 = date_2
        self.date_3 = date_3
        self.date_4 = date_4
        self.date_5 = date_5
        self.num_1 = num_1 ?? 0
        self.num_2 = num_2 ?? 0
        self.num_3 = num_3 ?? 0
        self.num_4 = num_4 ?? 0
        self.num_5 = num_5 ?? 0
        self.text_1 = text_1
        self.text_2 = text_2
        self.text_3 = text_3
        self.text_4 = text_4
        self.text_5 = text_5
        self.text_6 = text_6
        self.text_7 = text_7
        self.text_8 = text_8
        self.text_9 = text_9
        self.text_10 = text_10
    }
}
