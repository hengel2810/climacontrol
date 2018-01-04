//
//  ViewController.swift
//  climamqtt
//
//  Created by Henrik Engelbrink on 04.01.18.
//  Copyright © 2018 Henrik Engelbrink. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nominalTemperatureLabel: UILabel!
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var modeControl: UISegmentedControl!
    @IBOutlet weak var paramterTextfield: UITextField!
    @IBOutlet weak var valueTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nominalTemperatureLabel.text = "\(self.tempSlider.value)°C"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nominalTemperatureChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let nominalTemperature = String(format: "%.01f", slider.value)
            self.nominalTemperatureLabel.text = "\(nominalTemperature)°C"
        }
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        if let segmentControl = sender as? UISegmentedControl {
            switch(segmentControl.selectedSegmentIndex) {
            case 0:
                print("Heizen")
            case 1:
                print("Kühlen")
            case 2:
                print("Auto")
            case 3:
                print("Lüften")
            default:
                print("Mode not supported")
            }
        }
    }
    
    @IBAction func sendParamterValue(_ sender: Any) {
        self.paramterTextfield.resignFirstResponder()
        self.valueTextfield.resignFirstResponder()
        
    }
    
    @IBAction func openSettings(_ sender: Any) {
        
    }
    
}

