//
//  MainViewController.swift
//  RGB
//
//  Created by Андрей Поморцев on 20.03.2022.
//

import UIKit

protocol ColorSettigsViewControllerDelegate {
        var colorView: UIColor! { get set }
    }

class MainViewController: UIViewController & ColorSettigsViewControllerDelegate {
    
    var colorView: UIColor! {
        didSet {
            view.backgroundColor = colorView
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingViewController else { return }
        colorSettingsVC.colorMainView = view.backgroundColor
        colorSettingsVC.delegate = self
    }

}
