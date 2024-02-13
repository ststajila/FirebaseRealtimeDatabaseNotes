//
//  ViewController.swift
//  FirebaseRealtimeDatabaseNotes
//
//  Created by STANISLAV STAJILA on 2/7/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    var ref: DatabaseReference!
    var names: [String] = []
    var students: [Student] = []
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        ref = Database.database().reference()
        
        //reads all the children from the firebase
        ref.child("students").observe(.childAdded, with: { (snapshot) in
                  // snapshot is a dictionary with a key and a value
                   
                   // this gets each name from each snapshot
                   let n = snapshot.value as! String
                   // adds the name to an array if the name is not already there
                   if !self.names.contains(n){
                       self.names.append(n)
                   }
               })
        
        
        ref.child("student2").observe(.childAdded, with: { (snapshot) in
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
                    let dict = snapshot.value as! [String:Any]
                   
                    // building a Student object from the dictionary
                    let s = Student(dict: dict)
                    s.key = snapshot.key
                    // adding the student object to the Student array
                    
            var add = true
            for s1 in self.students{
                if s.key == s1.key{
                    add = false
                }
            }
            
            if add {
                self.students.append(s)
                self.tableViewOutlet.reloadData()
            }
                    
        // should only add the student if the student isn’t already in the array
        // good place to update the tableview also
                    
                })
        
        ref.child("student2").observe(.childRemoved) { snapshot in
            for student in self.students {
                if student.key == snapshot.key{
                   
                }
            }
        }

        
    }

    @IBAction func save(_ sender: Any) {
        var name = nameTextField.text
        ref.child("students").childByAutoId().setValue(name)
        tableViewOutlet.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        cell?.textLabel?.text = students[indexPath.row].name
        
        return cell!
    }
    
    @IBAction func saveStudent(_ sender: Any) {
    
        var n = nameTextField.text!
        var a = Int(ageOutlet.text!) ?? 0
        
        var student = Student(name: n, age: a)
        
        //students.append(student)
        
        student.saveToFirebase()
        
        tableViewOutlet.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            students[indexPath.row].deleteFromFirebase()
            students.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    
    
}

