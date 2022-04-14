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
            let alertView = UIView()
            alertView.backgroundColor = .red
            alertView.layer.cornerRadius = 8
            alertView.layer.cornerCurve = .continuous
            
            window.addSubview(alertView)
            
            alertView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alertView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 30),
                alertView.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor),
                alertView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -30),
            ])
            
            //Create an event view
            let eventView = EventView(event: event)
            let hostingController = UIHostingController(rootView: eventView)
            alertView.addSubview(hostingController.view)

            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: alertView.topAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
            ])
                        
            //Present and remove the alert
            alertView.transform = CGAffineTransform(translationX: 0, y: -300)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.86, initialSpringVelocity: 1.0, animations: {
                alertView.transform = .identity
            }) { _ in
                UIView.animate(withDuration: 0.35, delay: 1.6, animations: {
                    alertView.transform = CGAffineTransform(translationX: 0, y: -300)
                }) { _ in
                    alertView.removeFromSuperview()
                }
            }
            
        }
    }
    
    public init() {}
    
    public init(events: [Event]) {
        self.events = events
    }
}
