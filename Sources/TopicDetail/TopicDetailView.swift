//  TopicDetailView.swift
//  Created by DOMINIC NDONDO on 7/2/24.
import SwiftUI
import MQTT
import Models
import Charts

public struct TopicDetailView: View {
    @Binding var topic: TopicConnection
    @State var stream: Bool = false
    
    public var body: some View {
        VStack {
            // TODO: Description of the topic.
            Text(topic.description)
                .padding(.horizontal, 10)
            // TODO: Graph presentation for the data coming in from the mqtt client.
            Chart {
                ForEach(topic.plots) { plot in
                    LineMark(x: .value("x", plot.x), y: .value("y", plot.y))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .foregroundColor(.mint)
            .padding(.horizontal, 10)
            .chartXAxisLabel {
                Text("x/(unit)")
                    .font(.headline)
            }
            .chartYAxisLabel {
                Text("y/(unit)")
                    .font(.headline)
            }
            // TODO: Replace x and y and unit values
            Text("Graph showing x/{unit} vs y/{unit}")
                .italic()
            Spacer()
            // TODO: Change the toggle boolean value to something reasonable.
            Toggle("Stream Values", isOn: $stream)
                .padding(.horizontal, 10)
        }
        .navigationTitle(topic.name)
        .toolbar {
            ToolbarItem {
                Button("Delete") {
                    // TODO: Perform an action to delete the topic and dismiss the view
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TopicDetailView(
            topic: Binding(
                get: {.mock},
                set: { value in
                .mock = value
                }
            )
        )
    }
}
