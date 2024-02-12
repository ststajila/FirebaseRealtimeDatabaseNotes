//
//  ViewController.swift
//  FirebaseRealtimeDatabaseNotes
//
//  Created by STANISLAV STAJILA on 2/7/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
    }

    @IBAction func save(_ sender: Any) {
        var name = nameTextField.text
        ref.child("students").childByAutoId().setValue(name)
    }
    
}

