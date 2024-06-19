import Foundation

struct ItemContext: Encodable {
    var title: String
    var paramId: String?
    var errorMessage: String?
    var settings: SettingsDTO
    
    var items: [ListContentDTO]
}

