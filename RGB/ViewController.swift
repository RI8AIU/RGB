//
//  ViewController.swift
//  RGB
//
//  Created by Андрей Поморцев on 04.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        setColorView()
        setValueLabel()
        
    }
    
    @IBAction func changeRGBView(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = getValue(from: sender)
        case 1:
            greenLabel.text = getValue(from: sender)
//        case 2:
//            blueLabel.text = getValue(from: sender)
        default:
            blueLabel.text = getValue(from: sender)
        }
        setColorView()
    }
    
    private func setColorView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.0)
        
    }
    
    private func setValueLabel() {
        redLabel.text = getValue(from: redSlider)
        greenLabel.text = getValue(from: greenSlider)
        blueLabel.text = getValue(from: blueSlider)
    }
    
    private func getValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
