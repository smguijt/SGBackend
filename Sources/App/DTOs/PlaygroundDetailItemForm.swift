import Fluent
import Vapor

struct PlaygroundDetailItemForm: Content {
    
    let paramId: String?
    let text_1: String?
    let text_2: String?
    let text_3: String?
    let text_4: String?
    let text_5: String?
    let date_1: String?
    let date_2: String?
    let date_3: String?
    let date_4: String?
    let date_5: String?
    let int_1: String?
    let int_2: String?
    let int_3: String?
    let int_4: String?
    let int_5: String?
    
    init(paramId: String?, text_1: String?, text_2: String?, text_3: String?, text_4: String?, text_5: String?, date_1: String?, date_2: String?, date_3: String?, date_4: String?, date_5: String?, int_1: String?, int_2: String?, int_3: String?, int_4: String?, int_5: String?) {
        self.paramId = paramId
        self.text_1 = text_1
        self.text_2 = text_2
        self.text_3 = text_3
        self.text_4 = text_4
        self.text_5 = text_5
        self.date_1 = date_1
        self.date_2 = date_2
        self.date_3 = date_3
        self.date_4 = date_4
        self.date_5 = date_5
        self.int_1 = int_1
        self.int_2 = int_2
        self.int_3 = int_3
        self.int_4 = int_4
        self.int_5 = int_5
    }
    
    
}

