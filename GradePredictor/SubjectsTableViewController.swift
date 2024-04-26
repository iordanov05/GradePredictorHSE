//
//  SubjectsTableViewController.swift
//  GradePredictor
//
//  Created by Иорданов Павел on 23.04.2024.
//

import UIKit

class SubjectsTableViewController: UITableViewController {
    
    @IBOutlet weak var EditButton: UIBarButtonItem!

    @IBAction func PushEditAction(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            EditButton.title = "Изменить"
            dump(Subjects)
        } else {
            tableView.setEditing(true, animated: true)
            EditButton.title = "Готово"
        }
    }


    @IBAction func pushAddAction(_ sender: Any) {
        let alertController =  UIAlertController(title: "Новый предмет", message: nil, preferredStyle: .alert)
        
        alertController.addTextField{ (textField) in
            textField.placeholder = "Название предмета"
        }
        let alertAction1 = UIAlertAction(title: "Отмена", style: .cancel)
        { (alert) in
            
        }
        let alertAction2 = UIAlertAction(title: "Добавить", style: .default)
        { (alert) in
            let newSubject = alertController.textFields![0].text
            addSubject(name: newSubject!, mark: 0)
            self.tableView.reloadData()
        }
        
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Subjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentSubject = Subjects[indexPath.row]
        cell.textLabel?.text = currentSubject["Name"] as? String
        
//        if (currentSubject["isCompleted"] as? Bool) == true {
//            cell.accessoryType = .disclosureIndicator
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeSubject(at: indexPath.row) 
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = indexPath.row
        print("Нажал")
        let GradeStoryboard = UIStoryboard(name: "GradeViewController", bundle: nil)
        let GradeVC = GradeStoryboard.instantiateViewController(withIdentifier: "GradeViewController") as! GradeViewController
        GradeVC.selectedRow = selectedRow
        navigationController?.pushViewController(GradeVC, animated: true)
        
        
        
        
        
        
        
//        if changeState(at: indexPath.row){
//            tableView.cellForRow(at: indexPath)?.accessoryType = .disclosureIndicator
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveSubject(fromIndex: fromIndexPath.row, toIndex: to.row)

     
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
