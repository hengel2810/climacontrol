//
//  SettingsViewController.swift
//  climamqtt
//
//  Created by Henrik Engelbrink on 04.01.18.
//  Copyright © 2018 Henrik Engelbrink. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var hostTextfield: UITextField!
    @IBOutlet weak var portTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isEnabled = false
        let settings = SettingsController.loadSettings()
        if(settings != nil) {
            if settings!.host != nil {
                self.hostTextfield.text = settings!.host
            }
            if settings!.port != nil {
                self.portTextfield.text = "\(settings!.port!)"
            }
            if settings!.username != nil {
                self.usernameTextfield.text = settings!.username
            }
            if settings!.password != nil {
                self.passwordTextfield.text = settings!.password
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkInput() {
        let host = self.hostTextfield.text
        if (host == nil || host!.count < 6) {
            self.saveButton.isEnabled = false
            return
        }
        let port = Int(self.portTextfield.text!)
        if (port == nil) {
            self.saveButton.isEnabled = false
            return
        }
        let username = self.usernameTextfield.text
        if (username == nil || username!.count < 5) {
            self.saveButton.isEnabled = false
            return
        }
        let password = self.passwordTextfield.text
        if (password == nil || password!.count < 5) {
            self.saveButton.isEnabled = false
            return
        }
        self.saveButton.isEnabled = true
    }

    @IBAction func hostChanged(_ sender: Any) {
        self.checkInput()
    }
    
    @IBAction func portChanged(_ sender: Any) {
        self.checkInput()
    }
    
    @IBAction func usernameChanged(_ sender: Any) {
        self.checkInput()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        self.checkInput()
    }
    
    @IBAction func saveNewSettings(_ sender: Any) {
        let host = self.hostTextfield.text
        let port = Int(self.portTextfield.text!)
        let username = self.usernameTextfield.text
        let password = self.passwordTextfield.text
        let mqttSettings = MQTTSettings(host: host!, port: port!, username: username!, password: password!)
        print("###################################")
        SettingsController.save(settings: mqttSettings)
        
//        self.hostTextfield.resignFirstResponder()
//        self.portTextfield.resignFirstResponder()
//        self.usernameTextfield.resignFirstResponder()
//        self.passwordTextfield.resignFirstResponder()
    }
    
}
