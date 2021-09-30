//
//  MainTableVC.swift
//  CoreDataExample
//
//  Created by Murat Menzilci on 30.09.2021.
//

import UIKit

class MainTableVC: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items :[Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPeople()
    }
    
    func fetchPeople() {
        //Fetch data from Core Data to TableView
        
        do {
            self.items = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add person", message: "What's the name?", preferredStyle: .alert)
       
        alert.addTextField()
        
        let submitBtn = UIAlertAction(title: "Submit", style: .default) { (action) in
            
            let textfield = alert.textFields![0]
            
            let newPerson = Person(context: self.context)
            newPerson.name = textfield.text
            newPerson.age = 20
            newPerson.gender = "male"
            
            //Save the Data
            do{
                try! self.context.save()
            }
            catch{
                
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(submitBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let person = self.items![indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }

}
