import Foundation

struct ItemContext: Encodable {
    var title: String
    var settings: SettingsDTO
    
    var items: [ListContentDTO]
}

