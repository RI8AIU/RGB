//
//  ViewController.swift
//  RGB
//
//  Created by Андрей Поморцев on 04.03.2022.
//

import UIKit

class ColorSettingViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var colorMainView: UIColor!
    var delegate: ColorSettigsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15

        //setValueSlider()
        setValueLabel()
        setColorView()
        setValueTextField()
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
    }
    
    @IBAction func changeRGBView(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = getStringValue(from: sender)
            redTextField.text = getStringValue(from: sender)
        case 1:
            greenLabel.text = getStringValue(from: sender)
            greenTextField.text = getStringValue(from: sender)
        default:
            blueLabel.text = getStringValue(from: sender)
            blueTextField.text = getStringValue(from: sender)
        }
        setColorView()
    }
    
    
    @IBAction func doneButtonTapped() {
        delegate.colorView = colorView.backgroundColor
        dismiss(animated: true)
        
    }
    
    private func setColorView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.0)
        
    }
    
    private func setValueLabel() {
        
        redLabel.text = getStringValue(from: redSlider)
        greenLabel.text = getStringValue(from: greenSlider)
        blueLabel.text = getStringValue(from: blueSlider)
    }
    
    private func setValueTextField() {
        redTextField.text = getStringValue(from: redSlider)
        greenTextField.text = getStringValue(from: greenSlider)
        blueTextField.text = getStringValue(from: blueSlider)
        
    }
    
    private func getStringValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValueSlider() {
        
        // ВОЗМОЖНО ЭТОТ МЕТОД НЕ НУЖЕН!!!
        
        redSlider.setValue(Float(colorMainView.rgb.red), animated: true)
        greenSlider.setValue(Float(colorMainView.rgb.green), animated: true)
        blueSlider.setValue(Float(colorMainView.rgb.blue), animated: true)
        
    }
}

extension UIColor {
    
    var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
        
    }

}

extension ColorSettingViewController: UITextFieldDelegate {
    
    // Работа через кнопку Return
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        guard let value = Float(textField.text!) else {
//
//            let alert = UIAlertController(title: "Некорректный ввод!",
//                                          message: "Пожалуйста введите корректные данные.",
//                                          preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "OK", style: .default)
//
//            alert.addAction(okAction)
//            present(alert, animated: true)
//
//            textField.text?.removeAll()
//
//            return false
//        }
//
//        switch textField.tag {
//        case 0:
//            redSlider.setValue(value, animated: true)
//        case 1:
//            greenSlider.setValue(value, animated: true)
//        default:
//            blueSlider.setValue(value, animated: true)
//
//        }
//
//        view.endEditing(true)
//        setColorView()
//
//        return true
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = Float(textField.text!) else {
    // Кажется алерту здесь не место
            let alert = UIAlertController(title: "Некорректный ввод!",
                                          message: "Пожалуйста введите корректные данные.",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true)
            
            textField.text?.removeAll()
            
            return
        }
        
        switch textField.tag {
        case 0:
            redSlider.setValue(value, animated: true)
        case 1:
            greenSlider.setValue(value, animated: true)
        default:
            blueSlider.setValue(value, animated: true)
            
        }
        
        view.endEditing(true)
        setColorView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension ColorSettingViewController {
    
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar() // инициализация экземпляра класса Toolbar
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
        
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}
