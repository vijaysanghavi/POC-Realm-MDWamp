//
//  MDWampManager.swift
//  MDWAMP_Swift
//
//  Created by Vijay Sanghavi on 11/20/15.
//  Copyright © 2015 Vijay Sanghavi. All rights reserved.
//

import Foundation
import UIKit
import MDWamp

class MDWampManager: UIViewController, MDWampClientDelegate
{
    var manager: MDWampTransportWebSocket?
    var wamp: MDWamp?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.connectMdwamp()
    }
    
    func connectMdwamp()
    {
        self.manager = MDWampTransportWebSocket.init(server: NSURL.init(string: "ws://localhost:8080/ws") , protocolVersions: [kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        
        self.wamp = MDWamp.init(transport: self.manager, realm: "reach", delegate: self)
        
        self.wamp?.config.authid="authid"
        self.wamp?.config.authmethods = ["wampcra"]
        self.wamp?.config.sharedSecret="secret"
        self.wamp?.config.deferredWampCRASigningBlock = {( challenge: String!, finishBlock) -> Void in
            let sign = challenge.hmacSHA256DataWithKey("secret")
            print("Challenge \(challenge)")
            print("Signature \(sign)")
            finishBlock(sign)
        }
        
        self.wamp?.connect()
    }
    
    @IBAction func mdwampAction(sender: UIButton)
    {
        self.connectMdwamp()
    }
    
    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!)
    {
        print("Session Established")
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!)
    {
        print("Session Closed \n Code: \(code)\nReason: \(reason)")
    }
}