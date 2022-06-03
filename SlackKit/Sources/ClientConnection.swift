//
//  ClientConnection.swift
//  SlackKit
//
//  Created by Emory Dunn on 12/28/17.
//

import Foundation

public class ClientConnection {
    public var client: Client?
    public var webAPI: WebAPI?

    public init(client: Client?, webAPI: WebAPI?) {
        self.client = client
        self.webAPI = webAPI
    }
}
