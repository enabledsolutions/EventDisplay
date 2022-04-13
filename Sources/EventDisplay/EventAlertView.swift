//
//  EventAlertView.swift
//  
//
//  Created by Ariane Pearce on 12/4/22.
//

import SwiftUI

struct EventAlertView: View {
    var event: Event
    var body: some View {
        VStack {
            EventView(event: event)
        }
        .foregroundColor(.green)
        .padding(12)
        .background(Color.black)
        .cornerRadius(8)
        .fixedSize(horizontal: false, vertical: true)
    }
    
}

struct EventAlertView_Previews: PreviewProvider {
    static var previews: some View {
        EventAlertView(event: Event.test)
    }
}
