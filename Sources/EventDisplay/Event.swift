//
//  Event.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation

public struct Event {
    public enum Kind {
        case interaction
        case view
        case location
        case user
        case other
    }
    
    public let date: Date
    public let type: Kind
    public let name: String
    public let params: [String: Any]?
    
    public init(date: Date = Date(), type: Kind = .interaction, name: String, params: [String:Any]? = nil) {
        self.date = date        
        self.name = name
        self.type = type
        self.params = params
    }
}

extension Event.Kind {
    public var systemImageName: String {
        switch self {
        case .interaction:
            return "hand.tap.fill"
        case .view:
            return "eye.fill"
        case .location:
            return "location.fill"
        case .user:
            return "person.circle.fill"
        case .other:
            return "star.circle.fill"
        }
    }
}
