import Foundation
import Charts

public struct Plot: Equatable, Identifiable {
    public var x: Int
    public var y: Int
    public var id: UUID
    public init(x: Int, y: Int, id: UUID) {
        self.id = id
        self.x = x
        self.y = y
    }
}

public struct TopicConnection: Equatable, Identifiable{
    public var name: String
    public var description: String
    public var plots: [Plot]
    public var id: UUID
    public var connected: Bool
    public var dateCreated: Date
    public init(name: String, description: String, plots: [Plot], connected: Bool, dateCreated: Date,  id: UUID) {
        self.name = name
        self.description = description
        self.plots = plots
        self.id = id
        self.connected = connected
        self.dateCreated = dateCreated
    }
}

extension TopicConnection {
    public static var description: String =
    """
    This topic displays the x & y data plots published from the MQTT broker & running on localhost.\nNote that values coming from the stream have not gone through any model training but are published directly from the Python client.\n
    """
    public static var mock: TopicConnection = TopicConnection(name: "X-Y Plot", description: description, plots: mockPlots, connected: true, dateCreated: Date.now, id: UUID())
    public static var multipleConnections: [TopicConnection] = [
        TopicConnection(name: "Speed-Lux", description: "", plots: mockPlots, connected: false, dateCreated: Date.now, id: UUID()),
        TopicConnection(name: "Dist-Acc", description: "", plots: mockPlots, connected: true, dateCreated: Date.now, id: UUID()),
        mock
    ]
    public static var mockPlots: [Plot] = [
        Plot(x: 0, y: 1, id: UUID()),
        Plot(x: 2, y: 3, id: UUID()),
        Plot(x: 3, y: 5, id: UUID()),
        Plot(x: 5, y: 7, id: UUID()),
        Plot(x: 7, y: 11, id: UUID()),
        Plot(x: 8, y: 15, id: UUID())
    ]
}
