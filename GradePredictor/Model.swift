//
//  Model.swift
//  GradePredictor
//
//  Created by Иорданов Павел on 23.04.2024.
//

import Foundation

var Subjects: [String] = ["АИП", "Матанализ"]

func addSubject(nameSubject: String){
    Subjects.append(nameSubject)
    saveData()
    

}

func removeSubject(at index: Int){
    Subjects.remove(at: index)
    saveData()

}

func saveData(){
    
}

func loadData(){
    
}

