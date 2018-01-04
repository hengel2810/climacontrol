//
//  MQTTSettings.swift
//  climamqtt
//
//  Created by Henrik Engelbrink on 04.01.18.
//  Copyright © 2018 Henrik Engelbrink. All rights reserved.
//

import UIKit

struct MQTTSettings:Codable {
    
    init(host:String, port:Int, username:String, password:String) {
        self.host = host
        self.port = port
        self.username = username
        self.password = password
    }
    
    var host:String!
    var port:Int!
    var username:String!
    var password:String!
}

class SettingsController: NSObject {
    
    class func save(settings:MQTTSettings) {
        let encodedData = try! JSONEncoder().encode(settings)
        UserDefaults.standard.set(encodedData, forKey:"mqttSettings")
    }
    
    class func loadSettings() -> MQTTSettings? {
        let decodedData = UserDefaults.standard.object(forKey: "mqttSettings") as? Data
        if decodedData != nil {
            let settings = try! JSONDecoder().decode(MQTTSettings.self, from: decodedData!)
            return settings
        }
        return nil
    }
    
    
}
