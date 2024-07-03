//  TopicsListView.swift
//  Created by DOMINIC NDONDO on 7/2/24.
import SwiftUI
import Models

struct TopicsListView: View {
    @State var data: [TopicConnection] = TopicConnection.multipleConnections
    
    var body: some View {
        List {
            ForEach($data) { $topicData in
                // TODO: Cannot drill down into a topic if connection is not yet established.
                Button(action: {
                    // TODO: Send actions to the store here.
                } ) {
                    RowView(topic: $topicData)
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: { indexSet in
                // TODO: Do some deletion logice here and potentially add some moving logic as well based on Stewart Lynch's tutorials
            })
        }
        .navigationTitle("MQTT Connections")
        .toolbar {
            ToolbarItem(placement: .bottomBar){
                Button(action: {}) {
                    VStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Reconnect")
                    }
                }
                .frame(width: 200)
                .accentColor(.mint)
                .buttonStyle(.borderedProminent)
            }

            ToolbarItem(placement: .bottomBar){
                Button(action: {}) {
                    VStack{
                        Image(systemName: "dot.radiowaves.left.and.right")
                        Text("Add Topic")
                    }
                }
                .frame(width: 200)
                .accentColor(.mint)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct RowView: View {
    @Binding var topic: TopicConnection
    var body: some View {
        VStack(alignment: .leading) {
            // TODO: In the future provide a mechanism to pick an icon for a topic when making one using an enum that conforms to identifiable, caseiterable, equatable etc and a picker
            HStack {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.mint)
                    .padding(.bottom, 5)
                Spacer()
                HStack {
                    Text("Status")
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(topic.connected ? .mint : .orange)
                }
            }
            
            HStack {
                Text(topic.name)
                    .font(.headline)
                Spacer()
                Text("Created:")
                Text(topic.dateCreated, format: .dateTime.year().month().day())
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        TopicsListView()
    }
}
