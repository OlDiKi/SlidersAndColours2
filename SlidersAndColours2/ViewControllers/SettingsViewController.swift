//
//  SettingsViewController.swift
//  SlidersAndColours2
//
//  Created by Дмитрий Олейнер on 25.12.2021.
//

import UIKit


class SettingsViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorTF: UITextField!
    @IBOutlet weak var greenColorTF: UITextField!
    @IBOutlet weak var blueColorTF: UITextField!
    
    //MARK:  Properties
    
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        
        setSliders()
        setValueLabels()
        setValueTextFields()
    }
    
    //MARK: - IBAction's
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
      
        let savedColor = colorView.backgroundColor!
        delegate.setNewColor(color: savedColor)
        dismiss(animated: true)
    }
    
    @IBAction func rgbChanged(_ sender: UISlider) {
        changeColor()
        
        let value = String(format: "%.2f", sender.value)
        
        switch sender {
        case redColorSlider:
            redColorValue.text = value
            redColorTF.text = value
        case greenColorSlider:
            greenColorValue.text = value
            greenColorTF.text = value
        default:
            blueColorValue.text = value
            blueColorTF.text = value
        }
    }
    
}

//MARK: - Private Methods

extension SettingsViewController {
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
        }
    
    private func setSliders() {
        let newColor = CIColor(color: color)
        
        redColorSlider.value = Float(newColor.red)
        greenColorSlider.value = Float(newColor.green)
        blueColorSlider.value = Float(newColor.blue)
    }
    
    private func setValueLabels(for values: UILabel...) {
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
    
    private func setValueTextFields(for values: UITextField...) {
        values.forEach { value in
            switch value {
            case redColorTF:
                value.text = string(from: redColorSlider)
            case greenColorTF:
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

//MARK: - Alert

extension SettingsViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newValue = textField.text else { return }
        guard let currentValue = Float(newValue) else { return
            showAlert(title: "Wrong value!",
                      message: "Please enter correct number from 0 to 1")
        }
        
        if currentValue >= 0 && currentValue <= 1 {
            switch textField.tag {
            case 0: redColorSlider.value = currentValue
            case 1: greenColorSlider.value = currentValue
            case 2: blueColorSlider.value = currentValue
            default: break
            }
            changeColor()
            setValueLabels()
            setValueTextFields()
        } else {
            showAlert(title: "Wrong value!",
                      message: "Please enter correct number from 0 to 1")
        }
    }
}

