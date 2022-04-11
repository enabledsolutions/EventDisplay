//
//  EventStore.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation

public final class EventStore: ObservableObject {
    @Published var events: [Event] = []
    
    public func logEvent(_ event: Event) {
        events.append(event)
    }
    
    init() {}
    
    init(events: [Event]) {
        self.events = events
    }
}
