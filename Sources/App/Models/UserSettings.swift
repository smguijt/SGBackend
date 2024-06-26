//
//  UserSettings.swift
//  
//
//  Created by Sietse Guijt on 18/06/2024.
//

import Foundation
import Fluent

final class UserSettings: Model, @unchecked Sendable {
    static let schema = "user_settings"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "key")
    var key: String
    
    @Field(key: "value")
    var value: String

    @Field(key: "userId")
    var userId: UUID

    init() { }

    init(id: UUID? = nil, key: String, value: String, userId: UUID) {
        self.id = id
        self.key = key
        self.value = value
        self.userId = userId
    }

}
