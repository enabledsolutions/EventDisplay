//
//  EventStore.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import Foundation
import UIKit
import SwiftUI

public final class EventStore: ObservableObject {
    @Published var events: [Event] = []

    var sortedEvents: [Event] {
        events.sorted { event1, event2 in
            event2.date < event1.date
        }
    }
    
    public var windowForEventAlerts: UIWindow?
    
    public static let shared = EventStore()
    
    public func logEvent(_ event: Event) {
        events.append(event)
        
        if let window = windowForEventAlerts {
            //Create an event view
            let eventView = EventAlertView(event: event)
            let hostingController = UIHostingController(rootView: eventView)
            window.addSubview(hostingController.view)
            hostingController.view.backgroundColor = .red
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 30),
                hostingController.view.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -30),
            ])
                        
            //Present and remove the alert
            hostingController.view.transform = CGAffineTransform(translationX: 0, y: -300)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.86, initialSpringVelocity: 1.0, animations: {
                hostingController.view.transform = .identity
            }) { _ in
                UIView.animate(withDuration: 0.35, delay: 1.6, animations: {
                    hostingController.view.transform = CGAffineTransform(translationX: 0, y: -300)
                }) { _ in
                    hostingController.view.removeFromSuperview()
                }
            }
            
            hostingController.view.sizeToFit()
            
        }
    }
    
    public init() {}
    
    public init(events: [Event]) {
        self.events = events
    }
}
