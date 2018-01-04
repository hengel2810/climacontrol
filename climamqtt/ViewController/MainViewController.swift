//
//  ViewController.swift
//  climamqtt
//
//  Created by Henrik Engelbrink on 04.01.18.
//  Copyright © 2018 Henrik Engelbrink. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var nominalTemperatureLabel: UILabel!
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var modeControl: UISegmentedControl!
    @IBOutlet weak var fanControl: UISegmentedControl!
    @IBOutlet weak var paramterTextfield: UITextField!
    @IBOutlet weak var valueTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var mqttController:MQTTController?
    var sliderTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nominalTemperature = NSNumber(value: self.tempSlider.value)
        self.nominalTemperatureLabel.text = "\(nominalTemperature.intValue)°C"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(SettingsController.loadSettings() == nil) {
            let alert = UIAlertController(title: "MQTT Fehler", message: "Es gibt keine gültige MQTT-Konfiguration, bitte gehen Sie in die Einstellungen und geben Sie ihren MQTT-Broker an.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: {
                
            })
            self.tempSlider.isEnabled = false
            self.modeControl.isEnabled = false
            self.fanControl.isEnabled = false
            self.paramterTextfield.isEnabled = false
            self.valueTextfield.isEnabled = false
            self.sendButton.isEnabled = false
        }
        else {
            self.mqttController = MQTTController(mqttSettings: SettingsController.loadSettings()!)
            self.tempSlider.isEnabled = true
            self.modeControl.isEnabled = true
            self.fanControl.isEnabled = true
            self.paramterTextfield.isEnabled = true
            self.valueTextfield.isEnabled = true
            self.sendButton.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nominalTemperatureChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let nominalTemperature = NSNumber(value: slider.value)
            self.sliderTimer?.invalidate()
            self.sliderTimer = nil
            self.sliderTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                self.mqttController?.sendParameterValue(parameter: "211", value: "0\(nominalTemperature.intValue)")
            })
            self.nominalTemperatureLabel.text = "\(nominalTemperature.intValue)°C"
        }
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        if let segmentControl = sender as? UISegmentedControl {
            var value:Int = -1
            switch(segmentControl.selectedSegmentIndex) {
            case 0:
                value = 5
//                print("Heizen")
            case 1:
                value = 2
//                print("Kühlen")
            case 2:
                value = 0
//                print("Auto")
            case 3:
                value = 4
//                print("Lüften")
            default:
                print("Mode not supported")
            }
            self.mqttController?.sendParameterValue(parameter: "198", value: "00\(value)")
        }
    }
    
    @IBAction func fanChanged(_ sender: Any) {
        if let segmentControl = sender as? UISegmentedControl {
            var value:Int = -1
            if segmentControl.selectedSegmentIndex < 5 {
                value = segmentControl.selectedSegmentIndex + 1
//                print("Fan \(segmentControl.selectedSegmentIndex + 1)")
            }
            else if segmentControl.selectedSegmentIndex == 5 {
                value = 6
//                print("Fan Auto")
            }
            else if segmentControl.selectedSegmentIndex == 6 {
                value = 0
//                print("Fan Aus")
            }
            self.mqttController?.sendParameterValue(parameter: "199", value: "00\(value)")
        }
    }
    
    @IBAction func sendParamterValue(_ sender: Any) {
        self.paramterTextfield.resignFirstResponder()
        self.valueTextfield.resignFirstResponder()
        let parameter = self.paramterTextfield.text
        let value = self.valueTextfield.text
        if(parameter != nil && parameter!.count > 0 && value != nil && value!.count > 0) {
            self.mqttController?.sendParameterValue(parameter: parameter!, value: value!)
        }
        
    }
    
}

