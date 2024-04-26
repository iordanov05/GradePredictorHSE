
import UIKit
import Foundation

var Subjects: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "SubjectsDataKey")
        UserDefaults.standard.synchronize()
    }

    get {
        if let array = UserDefaults.standard.array(forKey: "SubjectsDataKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addSubject(name: String, mark: Int) {
    Subjects.append(["Name": name, "Criteria": [], "Mark": mark])
}

func addCriterion(subjectIndex: Int, criterionName: String, coefficient: Double) {
    if var subject = Subjects[subjectIndex] as? [String: Any] {
        if var criteria = subject["Criteria"] as? [[String: Any]] {
            criteria.append(["CriterionName": criterionName, "Coefficient": coefficient])
            subject["Criteria"] = criteria
            Subjects[subjectIndex] = subject
        }
    }
}

func removeSubject(at index: Int){
    Subjects.remove(at: index)
}

func moveSubject(fromIndex: Int, toIndex: Int){
    let from = Subjects[fromIndex]
    Subjects.remove(at: fromIndex)
    Subjects.insert(from, at: toIndex)
}
