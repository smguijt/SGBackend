//
//  Settings.swift
//  
//
//  Created by Sietse Guijt on 14/06/2024.
//

import Foundation
import Fluent

final class Setting: Model, @unchecked Sendable {
    static let schema = "settings"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "key")
    var key: String
    
    @Field(key: "value")
    var value: String

    init() { }

    init(id: UUID? = nil, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
    
    /*
    func toDTO() -> SettingDTO {
        .init(
            id: self.id,
            key: eSettings(rawValue: self.$key.value!)!,
            value: self.$value.value ?? ""
        )
    }
    */
}
