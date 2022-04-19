//
//  EventView.swift
//  
//
//  Created by Ariane Pearce on 11/4/22.
//

import SwiftUI

struct EventView: View {
    let event: Event
    var body: some View {
        HStack(alignment: .top) {
            Text(event.date.formatted(date: .omitted, time: .standard))
                .monospacedDigit()
                .foregroundColor(.green)
            
            Divider()
                .background(Color.green)
                .frame(width:3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: event.type.systemImageName)
                        .foregroundColor(.green)
                        .frame(width: 20)
                    Text(event.name)
                        .foregroundColor(.green)
                }
                
                if let params = event.params {
                    VStack(alignment: .leading) {
                        ForEach(Array(params.keys.sorted()), id: \.self) { key in
                            Text("\(key) = \(String(describing: params[key]!))")
                                .font(.monospaced(.caption)())
                                .foregroundColor(.green)
                                .padding(.leading, 30)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .font(.monospaced(.body)())
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EventView(event: .test)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(.black)
        }
    }
}
