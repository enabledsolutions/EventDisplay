//
//  Event.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation

public struct Event {
    public enum Kind {
        case touch
        case view
        case location
        case special
        case other
    }
    
    public let date: Date
    public let type: Kind
    public let name: String
    public let params: [String: Any]?
    
    public init(date: Date = Date(), type: Kind = .touch, name: String, params: [String:Any]? = nil) {
        self.date = date        
        self.name = name
        self.type = type
        self.params = params
    }
}

extension Event.Kind {
    var systemImageName: String {
        switch self {
        case .touch:
            return "hand.tap.fill"
        case .view:
            return "eye.fill"
        case .location:
            return "location.fill"
        case .special:
            return "star.fill"
        case .other:
            return "circle"
        }
    }
}
