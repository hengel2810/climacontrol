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
    @IBOutlet weak var fanControl: UISegmentedControl!
    @IBOutlet weak var paramterTextfield: UITextField!
    @IBOutlet weak var valueTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nominalTemperature = NSNumber(value: self.tempSlider.value)
        self.nominalTemperatureLabel.text = "\(nominalTemperature.intValue)°C"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nominalTemperatureChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let nominalTemperature = NSNumber(value: slider.value)
            self.nominalTemperatureLabel.text = "\(nominalTemperature.intValue)°C"
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
    @IBAction func fanChanged(_ sender: Any) {
        if let segmentControl = sender as? UISegmentedControl {
            if segmentControl.selectedSegmentIndex < 5 {
                print("Fan \(segmentControl.selectedSegmentIndex + 1)")
            }
            else if segmentControl.selectedSegmentIndex == 5 {
                print("Fan Auto")
            }
            else if segmentControl.selectedSegmentIndex == 6 {
                print("Fan Aus")
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

