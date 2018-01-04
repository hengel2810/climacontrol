//
//  MQTTController.swift
//  climamqtt
//
//  Created by Henrik Engelbrink on 04.01.18.
//  Copyright © 2018 Henrik Engelbrink. All rights reserved.
//

import UIKit
import CocoaMQTT

class MQTTController: NSObject, CocoaMQTTDelegate {

    var mqttClient:CocoaMQTT!
    
    init(mqttSettings:MQTTSettings) {
        super.init()
        let clientID = UUID().uuidString
        let port:UInt16 = UInt16(mqttSettings.port)
        self.mqttClient = CocoaMQTT(clientID: clientID, host: mqttSettings.host, port: port)
        self.mqttClient.username = mqttSettings.username
        self.mqttClient.password = mqttSettings.password
        self.mqttClient.keepAlive = 120
        self.mqttClient.delegate = self
        self.mqttClient.connect()
        print("Connect to MQTT Broker")
    }
    
    func sendParameterValue(parameter:String, value:String) {
        let message = "\(parameter)\(value)"
        print(message)
//        self.mqttClient.publish("singleParameter", withString: message)
        self.mqttClient.publish("singleParameter", withString: message, qos: CocoaMQTTQOS.qos2, retained: false, dup: false)
    }
    
    //MARK: - CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Connected \(host)")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Disconnected \(String(describing: err))")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    
}
