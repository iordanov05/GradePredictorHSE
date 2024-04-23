//
//  Model.swift
//  GradePredictor
//
//  Created by Иорданов Павел on 23.04.2024.
//

import Foundation

var Subjects: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "SubjectsDataKey")
        UserDefaults.standard.synchronize()
    }

    get {
        if let array = UserDefaults.standard.array(forKey: "SubjectsDataKey") as? [[String: Any]]{
            return  array
        } else {
        return []
        }
    }
}
func addSubject(nameSubject: String, isCompleted: Bool = false){
    Subjects.append(["Name": nameSubject, "isCompleted": false])
    

}

func removeSubject(at index: Int){
    Subjects.remove(at: index)

}

func moveSubject(fromIndex: Int, toIndex: Int){
    let from = Subjects[fromIndex]
    Subjects.remove(at: fromIndex)
    Subjects.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool{
    Subjects[item]["isCompleted"] = !(Subjects[item]["isCompleted"]  as! Bool)
    return (Subjects[item]["isCompleted"] as! Bool)
}
