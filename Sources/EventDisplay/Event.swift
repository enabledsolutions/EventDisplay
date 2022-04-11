//
//  Event.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation

public struct Event {
    enum Kind {
        case touch
        case view
        case location
        case special
        case other
    }
    
    let date: Date
    let type: Kind
    let name: String
    let params: [String: Any]?
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
