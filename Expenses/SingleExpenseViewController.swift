//
//  SingleExpenseViewController.swift
//  Expenses
//
//  Created by Tech Innovator on 11/30/17.
//  Copyright © 2017 Tech Innovator. All rights reserved.
//

import UIKit

class SingleExpenseViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var existingEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        locationTextField.delegate = self
        
        nameTextField.text = existingEvent?.eventName
        locationTextField.text = existingEvent?.eventLocation
        
        if let date = existingEvent?.date{
            datePicker.date = date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        let eventName = nameTextField.text
        let eventLocation = locationTextField.text
        let date = datePicker.date
        
        var event: Event?
        
        if let existingEvent = existingEvent{
            existingEvent.eventName = eventName
            existingEvent.eventLocation = eventLocation
            existingEvent.date = date
            
            event = existingEvent
            
        }else{
            event = Event(eventName: eventName, eventLocation: eventLocation, date: date)
        }
        
        if let event = event {
            do {
                let managedContext = event.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch{
                print("Event could not be saved.")
            }
    }
}

}

extension SingleExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  }

