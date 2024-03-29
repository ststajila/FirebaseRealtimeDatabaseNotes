//
//  Student.swift
//  FirebaseRealtimeDatabaseNotes
//
//  Created by STANISLAV STAJILA on 2/12/24.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class Student{
    var name: String
    var age: Int
    var ref = Database.database().reference()
    var key = ""
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(dict: [String: Any]){
        if let n = dict["name"] as? String{
            name = n
        } else{
            name = "Unknown"
        }
        
        if let a = dict["age"] as? Int{
            age = a
        } else{
            age = 0
        }
    }
    
    func saveToFirebase(){
        
        let dict = ["name": name, "age": age] as [String:Any]
        ref.child("student2").childByAutoId().setValue(dict)
        
        ref.child("student2").childByAutoId().key ?? "0"
        print(key)
        
        
        
    }
    
    func deleteFromFirebase(){
        print(key)
        ref.child("student2").child(key).removeValue()
        }

}
