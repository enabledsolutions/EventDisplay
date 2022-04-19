//
//  EventStore.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation
import UIKit
import SwiftUI

class SelfSizingHostingController<Content>: UIHostingController<Content> where Content: View {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.invalidateIntrinsicContentSize()
    }
}

public final class EventStore: ObservableObject {
    @Published var events: [Event] = []

    var sortedEvents: [Event] {
        events.sorted { event1, event2 in
            event2.date < event1.date
        }
    }
    
    public var displayEvent: ((Event) -> ())?

    public static let shared = EventStore()
    
    public func logEvent(_ event: Event) {
        events.append(event)
  
        if UserDefaults.standard.bool(forKey: "showEventsOnTap") {
            dispatchEventForDisplay(event)
        }
    }
    
    public init() {}
    
    public init(events: [Event]) {
        self.events = events
    }
    
    //MARK: - Event Display Dispatch
    
    private let queue = DispatchQueue(label: "myraa.analytcs.display.events", qos: .userInteractive)
    private let semaphore = DispatchSemaphore(value: 1)
    
    private func dispatchEventForDisplay(_ event: Event) {
        queue.async {
            self.semaphore.wait()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                self.displayEvent?(event)
                
                //After 1 second, allow next events through
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.semaphore.signal()
                }
            }
        }
    }
}
