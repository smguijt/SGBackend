import Foundation

struct PlaygroundItemContext: Encodable {
    var title: String
    var paramId: String?
    var errorMessage: String?
    var settings: SettingsDTO
    var general: PlaygroundGeneralDTO
    var additionaldata: PlaygroundAdditionalDataDTO?
    var entity: [PlaygroundEntity]?
}

