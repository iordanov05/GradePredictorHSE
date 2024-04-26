//
//  GradeViewController.swift
//  GradePredictor
//
//  Created by Иорданов Павел on 26.04.2024.
//

import UIKit

class GradeViewController: UIViewController{
    var selectedRow: Int!
    @IBOutlet weak var GradeTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = Subjects[selectedRow]["Name"] as? String {
            GradeTitle.title = name
        }
    }
    
    @IBAction func pushAddGradeAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Новый критерий", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Критерий"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Коэффициент"
            textField.keyboardType = .decimalPad
        }
        
        let alertAction1 = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }
        
        let alertAction2 = UIAlertAction(title: "Добавить", style: .default) { (_) in
            if let criterionText = alertController.textFields?[0].text, !criterionText.isEmpty,
                let coefficientText = alertController.textFields?[1].text,
                let coefficient = Double(coefficientText),
                coefficient > 0, coefficient <= 1 {
                    // Логика в случае успешного ввода и соответствия условиям
            } else {
                // Отображение сообщения об ошибке, поскольку условия не выполнены
                let errorAlert = UIAlertController(title: "Ошибка", message: "Коэффициент должен представлять собой числовое значение в форме десятичной дроби, которое должно быть больше 0 и меньше 1.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            }

        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }

}
