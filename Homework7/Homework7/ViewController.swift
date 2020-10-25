//
//  ViewController.swift
//  Homework7
//
//  Created by Robert Mukhtarov on 24.10.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private var tableView: UITableView!
    private var contacts = [
        Contact(name: "Anna", surname: "Haro", number: "(555) 522-8243"),
        Contact(name: "David", surname: "Taylor", number: "(555) 610-6679"),
        Contact(name: "Daniel", surname: "Higgins Jr", number: "(555) 478-7672"),
        Contact(name: "Hank", surname: "Zakroff", number: "(555) 766-4823"),
        Contact(name: "John", surname: "Appleseed", number: "(555) 555-5512"),
        Contact(name: "Kate", surname: "Bell", number: "(555) 564-8583"),
        Contact(name: "Robert", surname: "Mukhtarov", number: "(123) 456-7890"),
        Contact(name: "Dennis", surname: "Hamill", number: "(902) 928-5825"),
        Contact(name: "Donald", surname: "Duck", number: "(098) 765-4321"),
        Contact(name: "Alexander", surname: "Ivanov", number: "(999) 123-4321"),
        Contact(name: "Henry", surname: "Richardson", number: "(141) 831-2387")
    ]
    private var contactsDictionary: [String : [Contact]] = [:]
    private var sectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        contacts.sort { $0.name < $1.name }
        contactsDictionary = Dictionary(grouping: contacts) { String($0.name.first!) }
        sectionTitles = contactsDictionary.keys.sorted()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsDictionary[sectionTitles[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = contactsDictionary[sectionTitles[indexPath.section]]?[indexPath.row].name
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContactViewController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContactViewController" {
            if let contactVC = segue.destination as? ContactViewController {
                let indexPath = tableView.indexPathForSelectedRow!
                contactVC.contact = contactsDictionary[sectionTitles[indexPath.section]]?[indexPath.row]
            }
        }
    }
        
}
