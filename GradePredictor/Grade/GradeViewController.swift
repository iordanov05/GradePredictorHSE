import UIKit

class GradeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedRow: Int!
    @IBOutlet weak var GradeTitle: UINavigationItem!
//    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var GradeTableCriteria: UITableView!
    @IBOutlet weak var GradeTableCoefficient: UITableView!
    @IBOutlet weak var GradeTableMark: UITableView!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var GradeEditButton: UIBarButtonItem!
    @IBAction func GradeEditAction(_ sender: Any) {
       
            if GradeTableCriteria.isEditing {
                GradeTableCriteria.setEditing(false, animated: true)
                GradeEditButton.title = "Изменить"
                dump(Subjects)
            } else {
                // Начинаем редактирование всех таблиц
                GradeTableCriteria.setEditing(true, animated: true)
//                GradeTableCoefficient.setEditing(true, animated: true)
//                GradeTableMark.setEditing(true, animated: true)
                GradeEditButton.title = "Готово"
            
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if tableView == GradeTableCriteria && editingStyle == .delete {
                criteriaData.remove(at: indexPath.row)
                coefficientData.remove(at: indexPath.row)
                markDataArray.remove(at: indexPath.row)
                
                // Удаляем выбранные строки из всех таблиц и обновляем данные
                GradeTableCriteria.deleteRows(at: [indexPath], with: .fade)
                GradeTableCoefficient.reloadData()
                GradeTableMark.reloadData()
                
                calculateResult() // Пересчитываем результат после удаления строк
            }
        }

    }

   


    var result: Double = 0.0
    var criteriaData: [String] = []
    var coefficientData: [Double] = []
    var markDataArray: [Double] = []
    func calculateResult() {
        result = 0.0 // Обнуляем результат перед пересчетом

        // Проходим по каждой строке и умножаем значение из GradeTableCoefficient на значение из GradeTableMark, затем прибавляем к текущему результату
        for i in 0..<coefficientData.count {
            result += coefficientData[i] * markDataArray[i]
        }

        ResultLabel.text = "ИТОГО: \(result)" // Обновляем метку с результатом
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GradeTableCriteria.register(UITableViewCell.self, forCellReuseIdentifier: "CellCriteria")
        GradeTableCoefficient.register(UITableViewCell.self, forCellReuseIdentifier: "CellCoefficient")
        GradeTableMark.register(UITableViewCell.self, forCellReuseIdentifier: "CellMark")
          

        GradeTableCriteria.delegate = self
        GradeTableCriteria.dataSource = self
        GradeTableCoefficient.delegate = self
        GradeTableCoefficient.dataSource = self
        GradeTableMark.delegate = self
        GradeTableMark.dataSource = self
//        GradeTableCoefficient.dataSource = self


//        criteriaLabel.textAlignment = .left
        updateCriteriaLabel()  // Вызываем метод обновления метки criteriaLabel при загрузке представления
    }

    func updateCriteriaLabel() {
        if let subject = Subjects[selectedRow] as? [String: Any],
            let name = subject["Name"] as? String,
            let criteria = subject["Criteria"] as? [[String: Any]] {
            
            GradeTitle.title = name
            
            criteriaData.removeAll()
            coefficientData.removeAll()
            markDataArray.removeAll() // Очищаем markDataArray при каждом обновлении
            
            for criterion in criteria {
                if let criterionName = criterion["CriterionName"] as? String, let coefficient = criterion["Coefficient"] as? Double, let mark = subject["Mark"] as? Double {
                    criteriaData.append(criterionName)
                    coefficientData.append(coefficient)
                    markDataArray.append(mark)
                }
            }
            
            GradeTableCriteria.reloadData()
            GradeTableCoefficient.reloadData()
            GradeTableMark.reloadData()
        }
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == GradeTableCriteria {
            return criteriaData.count // Возвращаем количество элементов массива criteriaData
        } else if tableView == GradeTableCoefficient {
            return coefficientData.count // Возвращаем количество элементов массива coefficientData
        } else if tableView == GradeTableMark{
            return markDataArray.count
        }
        return 0
    }

//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == GradeTableCriteria {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCriteria", for: indexPath)
            cell.layer.borderWidth = 1.0
               cell.layer.borderColor = UIColor.gray.cgColor
               //cell.layer.cornerRadius = 5.0
            cell.textLabel?.text = "\(criteriaData[indexPath.row])"  // Устанавливаем текст ячейки для критериев
            return cell
        } else if tableView == GradeTableCoefficient {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCoefficient", for: indexPath)
            cell.layer.borderWidth = 1.0
               cell.layer.borderColor = UIColor.gray.cgColor
              // cell.layer.cornerRadius = 5.0
            cell.textLabel?.text = "\(coefficientData[indexPath.row])" // Устанавливаем текст ячейки для коэффициентов
            return cell
        }else if tableView == GradeTableMark {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellMark", for: indexPath)
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.accessoryType = .detailButton
               //cell.layer.cornerRadius = 5.0
            cell.textLabel?.text = "\(markDataArray[indexPath.row])"
            
      
                   
//            let button = UIButton(type: .system)
//            button.frame = CGRect(x: 63, y: 12, width: 18, height: 18)
//            button.contentMode = .scaleToFill
//            button.isOpaque = false
//            button.contentHorizontalAlignment = .center
//            button.contentVerticalAlignment = .center
//            button.titleLabel?.lineBreakMode = .byTruncatingMiddle
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.setTitle("+", for: .normal)
//            button.backgroundColor = .systemBlue
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
//                   cell.contentView.addSubview(button)

            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == GradeTableMark { // Проверяем, что нажата ячейка в таблице GradeTableMark
            let alertController = UIAlertController(title: "Введите оценку", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Оценка за элемент контроля"
                textField.keyboardType = .decimalPad
            }
            
            let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
                if let text = alertController.textFields?.first?.text,
                   let number = Double(text) {
                    self.markDataArray[indexPath.row] = number // Обновляем данные в markDataArray
                    tableView.reloadRows(at: [indexPath], with: .automatic) // Перезагружаем ячейку
                    self.calculateResult() // Вызываем метод расчета результата
                }
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }
    }

    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell

//        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as? UITableViewCell {
//            cell = reusableCell
//        } else {
//            cell = UITableViewCell()
//        }
//
//        cell.layer.borderWidth = 1.0
//        cell.layer.borderColor = UIColor.gray.cgColor
//
//        if tableView == GradeTableCriteria {
//            cell.textLabel?.text = criteriaData[indexPath.row]
//        } else if tableView == GradeTableCoefficient {
//            cell.textLabel?.text = String(coefficientData[indexPath.row])
//        } else if tableView == GradeTableMark {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//            label.text = String(markDataArray[indexPath.row])
//            label.textAlignment = .center
//            label.layer.borderWidth = 1.0
//            label.layer.borderColor = UIColor.black.cgColor
//            label.layer.cornerRadius = 15.0
//            label.clipsToBounds = true
//
//            let button = UIButton(type: .custom)
//            button.frame = CGRect(x: 40, y: 0, width: 30, height: 30)
//            button.setTitle("+", for: .normal)
//            button.setTitleColor(.blue, for: .normal)
//            button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
//
//            cell.addSubview(label)
//            cell.addSubview(button)
//        }
//
//        return cell
//    }


    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: 1)
            borderLayer.backgroundColor = UIColor.gray.cgColor
            cell.layer.addSublayer(borderLayer)
        }
    }



    // Метод для добавления нового критерия с коэффициентом
    func addCriterion(subjectIndex: Int, criterionName: String, coefficient: Double) {
        if subjectIndex < Subjects.count {
            if var subject = Subjects[subjectIndex] as? [String: Any],
               var criteria = subject["Criteria"] as? [[String: Any]] {
                let newCriterion = ["CriterionName": criterionName, "Coefficient": coefficient] as [String: Any]
                criteria.append(newCriterion)
                subject["Criteria"] = criteria
                print(markDataArray)
                Subjects[subjectIndex] = subject // Обновляем данные о предмете в массиве Subjects

                if let mark = subject["mark"] as? Double {
                    markDataArray.append(mark) // Добавляем значение 'mark' в массив данных для таблицы GradeTableMark
                }

                updateCriteriaLabel() // Обновляем данные
                GradeTableCriteria.reloadData() // Перезагружаем таблицу с критериями
                GradeTableCoefficient.reloadData() // Перезагружаем таблицу с коэффициентами
                GradeTableMark.reloadData() // Перезагружаем таблицу с оценками
                
            }
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

        let alertAction1 = UIAlertAction(title: "Отмена", style: .cancel) { _ in }

        let alertAction2 = UIAlertAction(title: "Добавить", style: .default) { _ in
            validateAndAddCriterion()
    
        }

        func validateAndAddCriterion() {
            guard let criterionText = alertController.textFields?[0].text, !criterionText.isEmpty else {
                displayError(message: "Критерий не должен быть пустым")
                return
            }

            guard let coefficientText = alertController.textFields?[1].text, let coefficient = Double(coefficientText), coefficient > 0, coefficient < 1 else {
                displayError(message: "Коэффициент должен быть числом в диапазоне от 0 до 1")
                return
            }

            if let selectedRow = self.selectedRow {
                self.addCriterion(subjectIndex: selectedRow, criterionName: criterionText, coefficient: coefficient)
            }
        }

        func displayError(message: String) {
            let errorAlert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            errorAlert.addAction(okAction)
            self.present(errorAlert, animated: true, completion: nil)
        }

        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)

                present(alertController, animated: true, completion: nil)

                // Обновляем метку criteriaLabel после добавления нового критерия
                updateCriteriaLabel()
            }
    @objc func plusButtonTapped() {}
        }


