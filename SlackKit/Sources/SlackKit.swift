//
// SlackKit.swift
//
// Copyright © 2017 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
#if !COCOAPODS
@_exported import SKClient
@_exported import SKCore
@_exported import SKWebAPI
#endif

public final class SlackKit {

    public typealias EventClosure = (Event, ClientConnection?) -> Void
    internal typealias TypedEvent = (EventType, EventClosure)
    internal var callbacks = [TypedEvent]()
    internal(set) public var clients: [String: ClientConnection] = [:]

    /// Return the `WebAPI` instance of the first client
    public var webAPI: WebAPI? {
        return clients.values.first?.webAPI
    }

    public init() {}

    public func addWebAPIAccessWithToken(_ token: String) {
        let webAPI = WebAPI(token: token)
        if let clientConnection = clients[token] {
            clientConnection.webAPI = webAPI
        } else {
            clients[token] = ClientConnection(client: nil, webAPI: webAPI)
        }
    }

    // MARK: - Callbacks
    public func notificationForEvent(_ type: EventType, event: @escaping EventClosure) {
        callbacks.append((type, event))
    }

    private func executeCallbackForEvent(_ event: Event, type: EventType, clientConnection: ClientConnection?) {
        let cbs = callbacks.filter {$0.0 == type}
        for callback in cbs {
            callback.1(event, clientConnection)
        }
    }
}
