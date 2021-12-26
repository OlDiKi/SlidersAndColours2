//
//  ViewController.swift
//  SlidersAndColours2
//
//  Created by Дмитрий Олейнер on 25.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(color: UIColor) {
        view.backgroundColor = color
    }
    
}

