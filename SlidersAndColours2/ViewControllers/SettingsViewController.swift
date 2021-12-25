//
//  SettingsViewController.swift
//  SlidersAndColours2
//
//  Created by Дмитрий Олейнер on 25.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorText: UITextField!
    @IBOutlet weak var greenColorText: UITextField!
    @IBOutlet weak var blueColorText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        
        changeColor()
        setValue(for: redColorValue, greenColorValue, blueColorValue)

    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func rgbChanged(_ sender: UISlider) {
        changeColor()
        
        switch sender {
        case redColorSlider: setValue(for: redColorValue)
        case greenColorSlider: setValue(for: greenColorValue)
        default: setValue(for: blueColorValue)
        }
    }
    
//MARK: - Private methods
    
private func changeColor() {
    colorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
    }
    
private func setValue(for values: UILabel...) {
    values.forEach { value in
        switch value {
        case redColorValue:
            value.text = string(from: redColorSlider)
        case greenColorValue:
            value.text = string(from: greenColorSlider)
        default:
            value.text = string(from: blueColorSlider)
        }
    }
}
    
private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


