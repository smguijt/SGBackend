import Fluent
import Vapor

struct PlaygroundDetailItemForm: Content {
    
    let paramId: String?
    let text_1: String?
    let date_1: String?
    
    init(paramId: String?, text_1: String?, date_1: String?) {
        self.paramId = paramId
        self.text_1 = text_1
        self.date_1 = date_1
    }
}

