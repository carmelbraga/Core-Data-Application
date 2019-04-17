//
//  ExpensesViewController.swift
//  Expenses
//
//  Created by Tech Innovator on 11/30/17.
//  Copyright © 2017 Tech Innovator. All rights reserved.
//

import UIKit
import CoreData

class ExpensesViewController: UIViewController {
    
    @IBOutlet weak var expensesTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expensesTableView.dataSource = self
        expensesTableView.delegate = self 
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        do{
            events = try managedContext.fetch(fetchRequest)
            
        
            expensesTableView.reloadData()
        } catch{
            print("Fetch could not be performed.")
        }
    
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewExpense(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleExpenseViewController,
              let selectedRow = self.expensesTableView.indexPathForSelectedRow?.row else{
        return
    }
        
        destination.existingEvent = events[selectedRow]
    }

    func deleteEvent(at indexPath: IndexPath){
        let event = events[indexPath.row]
        
        if let managedContext = event.managedObjectContext{
            managedContext.delete(event)
            
            do{
                try managedContext.save()
                
                self.events.remove(at: indexPath.row)
                
                expensesTableView.deleteRows(at: [indexPath], with: .automatic)
            }catch{
                print("Event could not be deleted.")
                
                expensesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension ExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteEvent(at: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        let event = events[indexPath.row]
        
        cell.textLabel?.text = event.eventName
        
        if let date = event.date{
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }
        
        return cell
    }
}

extension ExpensesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showExpense", sender: self)
    }
}
