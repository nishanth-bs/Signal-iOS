//
//  Copyright (c) 2021 Open Whisper Systems. All rights reserved.
//

import Foundation
import PromiseKit

@objc
public class SocketManager: NSObject {

    private let websocketIdentified = OWSWebSocket(webSocketType: .identified)
    private let websocketUnidentified = OWSWebSocket(webSocketType: .unidentified)

    @objc
    public required override init() {
        AssertIsOnMainThread()

        super.init()

        SwiftSingletons.register(self)
    }

    private func webSocket(ofType webSocketType: OWSWebSocketType) -> OWSWebSocket {
        switch webSocketType {
        case .identified:
            return websocketIdentified
        case .unidentified:
            return websocketUnidentified
        }
    }

    public func canMakeRequests(webSocketType: OWSWebSocketType) -> Bool {
        webSocket(ofType: webSocketType).canMakeRequests
    }

    private func makeRequest(_ request: TSRequest,
                            webSocketType: OWSWebSocketType,
                            success: @escaping TSSocketMessageSuccess,
                            failure: @escaping TSSocketMessageFailure) {
        webSocket(ofType: webSocketType).makeRequest(request, success: success, failure: failure)
    }

    private func waitForSocketToOpen(webSocketType: OWSWebSocketType,
                                     waitStartDate: Date = Date()) -> Promise<Void> {
        let webSocket = self.webSocket(ofType: webSocketType)
        if webSocket.canMakeRequests {
            // The socket is open; proceed.
            return Promise.value(())
        }
        guard webSocket.shouldSocketBeOpen else {
            // The socket wants to be open, but isn't.
            // Proceed even though we will probably fail.
            return Promise.value(())
        }
        let maxWaitInteral = kSecondInterval * 30
        guard abs(waitStartDate.timeIntervalSinceNow) < maxWaitInteral else {
            // The socket wants to be open, but isn't.
            // Proceed even though we will probably fail.
            return Promise.value(())
        }
        return firstly(on: .global()) {
            after(seconds: kSecondInterval / 10)
        }.then(on: .global()) {
            self.waitForSocketToOpen(webSocketType: webSocketType,
                                     waitStartDate: waitStartDate)
        }
    }

    // This method can be called from any thread.
    func makeRequestPromise(request: TSRequest) -> Promise<HTTPResponse> {
        let webSocketType: OWSWebSocketType = {
            if request.isUDRequest {
                return .unidentified
            } else if !request.shouldHaveAuthorizationHeaders {
                return .unidentified
            } else {
                return .identified
            }
        }()
        return makeRequestPromise(request: request, webSocketType: webSocketType)
    }

    // This method can be called from any thread.
    private func makeRequestPromise(request: TSRequest,
                                    webSocketType: OWSWebSocketType) -> Promise<HTTPResponse> {

        // webSocketType, isUDRequest and shouldHaveAuthorizationHeaders
        // should be (mostly?) aligned.
        switch webSocketType {
        case .identified:
            owsAssertDebug(!request.isUDRequest)
            owsAssertDebug(request.shouldHaveAuthorizationHeaders)
            if request.isUDRequest || !request.shouldHaveAuthorizationHeaders {
                Logger.info("request: \(String(describing: request.url)), isUDRequest: \(request.isUDRequest), shouldHaveAuthorizationHeaders: \(request.shouldHaveAuthorizationHeaders)")
            }
        case .unidentified:
            owsAssertDebug(request.isUDRequest || !request.shouldHaveAuthorizationHeaders)
            if !request.isUDRequest && request.shouldHaveAuthorizationHeaders {
                Logger.info("request: \(String(describing: request.url)), isUDRequest: \(request.isUDRequest), shouldHaveAuthorizationHeaders: \(request.shouldHaveAuthorizationHeaders)")
            }
        }

        return firstly(on: .global()) {
            self.waitForSocketToOpen(webSocketType: webSocketType)
        }.then(on: .global()) { () -> Promise<HTTPResponse> in
            let (promise, resolver) = Promise<HTTPResponse>.pending()
            self.makeRequest(request,
                             webSocketType: webSocketType,
                             success: { (response: HTTPResponse) in
                                resolver.fulfill(response)
                             },
                             failure: { (failure: OWSHTTPErrorWrapper) in
                                resolver.reject(failure.error)
                             })
            return promise
        }
    }

    // This method can be called from any thread.
    @objc
    public func requestSocketOpen() {
        websocketIdentified.requestOpen()
        websocketUnidentified.requestOpen()
    }

    @objc
    public func cycleSocket() {
        AssertIsOnMainThread()

        websocketIdentified.cycle()
        websocketUnidentified.cycle()
    }

    @objc
    public var isAnySocketOpen: Bool {
        // TODO: Use CaseIterable
        (socketState(forType: .identified) == .open ||
         socketState(forType: .unidentified) == .open)
    }

    public func socketState(forType webSocketType: OWSWebSocketType) -> OWSWebSocketState {
        webSocket(ofType: webSocketType).state
    }

    public var hasEmptiedInitialQueue: Bool {
        websocketIdentified.hasEmptiedInitialQueue
    }
}
