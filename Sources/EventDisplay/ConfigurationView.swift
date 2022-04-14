//
//  ConfigurationView.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import SwiftUI

extension Event {
    static let test = Event(date: Date(), type: .touch, name: "Test", params: ["value": true, "anotherOne": 12345, "anotherthing": "string"])
    static let test2 = Event(date: Date(timeIntervalSince1970: 344000), type: .special, name: "Test2", params: ["exists": false])
    static let test3 = Event(date: Date(timeIntervalSince1970: 123456783), type: .other, name: "Test3", params: nil)
    static let test4 = Event(date: Date(timeIntervalSince1970: 426347364), type: .view, name: "Test4", params: nil)
    static let test5 = Event(date: Date(timeIntervalSince1970: 0), type: .location, name: "Test5", params: nil)
}

public struct ConfigurationView: View {
    @AppStorage("showEventsOnTap", store: .standard) var showEventsOnTap = true
    
    @EnvironmentObject var eventsStore: EventStore
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Toggle(isOn: $showEventsOnTap) {
                Text("Show Events On Tap")
                    .font(.monospaced(.body)())
                    .foregroundColor(.green)
            }
            .padding(.bottom)
            
            Text("Current Session Events")
                .font(.monospaced(.body)())
                .foregroundColor(.green)
                .padding(.bottom)
            
            Divider()
                .background(Color.green)
                .frame(height:3)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(eventsStore.events, id: \.name) { event in
                        EventView(event: event)
                    }
                    .padding([.top, .bottom])
                }
            }
            
        }
        .padding()
        .background(Color.black)
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView().environmentObject(EventStore(events: [Event.test, Event.test2, Event.test3, Event.test4, Event.test5]))
    }
}
