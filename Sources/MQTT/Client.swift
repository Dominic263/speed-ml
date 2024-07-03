//  Client.swift
//  This file contains the main app dependency MQTTNIO
//  Created by DOMINIC NDONDO on 6/27/24.
import ComposableArchitecture
import Foundation
import MQTTNIO
import NIO

@DependencyClient
struct Client {
    static var client: MQTTClient?
    var connect: @Sendable (String, Int, String) async throws -> Void
    var subscribe: @Sendable (MQTTSubscribeInfo) async throws -> Void
    var getPublishListener: @Sendable () throws -> MQTTPublishListener
    var publish: @Sendable (String, String) -> Void
    var shutdown: @Sendable (MQTTClient) async throws -> Void
    var checkIsActive: @Sendable () -> Bool = { false }
}

extension Client: DependencyKey  {
    static let liveValue: Client = Self(
        connect: { host, port, id in
            Self.client = MQTTClient(host: host, port: port,  identifier: id, eventLoopGroupProvider: .createNew)
            do {
                try await Self.client?.connect(cleanSession: true)
            } catch {
                print("Connection Error: \(error)")
            }
        },
        subscribe: { subscribeInfo in
            _ = Self.client?.subscribe(to: [subscribeInfo])
        },
        getPublishListener: {
            struct ListenerError: Error {}
            guard let client = Self.client else {
                throw ListenerError()
            }
            return client.createPublishListener()
        },
        publish: { topic, message in
            _ = Self.client?.publish(to: topic, payload: ByteBuffer(string: message) , qos: .atLeastOnce)
        },
        shutdown: { client in
            if(client.isActive()){
                do {
                    try await Self.client?.shutdown()
                }
                catch {
                    print("Shutdown Error: \(error)")
                }
            }
        },
        checkIsActive: {
            return client?.isActive() == true ? true : false
        }
    )
}

extension DependencyValues {
  var mqttClient: Client {
    get { self[Client.self] }
    set { self[Client.self] = newValue }
  }
}
