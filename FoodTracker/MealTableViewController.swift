//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Lucas Deane on 18.08.18
//  Copyright © 2018 Lucas Deane. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: Properties
    var students = [Student]()
    
    // MARK: Checkmarks
    
    
    //MARK: Search Bar
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false;
    
    var filteredStudents = [Student]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //search bar config
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    
    

    // Load any saved students, otherwise load sample data.
        
    if let savedStudents = loadStudents() {
      students += savedStudents
      printStudents() // Debug
    }
    else {
      // Load the sample data.
      loadSampleStudents()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

  func loadSampleStudents() {
    let s1 = Student(name: "Lucas Deane", ID: "119221", rating: 5)!

    let s2 = Student(name: "Steve Williams", ID: "119564", rating: 4)!

    let s3 = Student(name: "Dan Stewart", ID: "119891", rating: 3)!

    students += [s1, s2, s3]
    printStudents() // Debug
  }

  func printStudents() {
    var i = 0
    for student in students {
      print("student.name: [\(i)] '\(student.name)'") // Debug
      i += 1
    }
  }
    
    func printStudentsCheck() {
        var i = 0
        for student in students {
            print("student.checked: [\(i)] '\(student.checked)'") // Debug
            i += 1
        }
    }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return students.count
    
    if isSearching {
        return filteredStudents.count
    } else {
        return students.count
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "MealTableViewCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
    
    //set up food label
    func setupFoodLabel() {
        if (cell.ratingControl.rating == 0) {
            cell.foodLabel?.text = "Cane's-TOAST"
            cell.foodPhoto.image = #imageLiteral(resourceName: "CanesToast")
        } else if (cell.ratingControl.rating == 1) {
            cell.foodLabel?.text = "Cane's-COLESLAW"
            cell.foodPhoto.image = #imageLiteral(resourceName: "CanesColeslaw")
        } else if (cell.ratingControl.rating == 2) {
            cell.foodLabel?.text = "Cane's-THREE PIECE"
            cell.foodPhoto.image = #imageLiteral(resourceName: "CanesThreePiece")
        } else if (cell.ratingControl.rating == 3) {
            cell.foodLabel?.text = "General Tso Chicken"
            cell.foodPhoto.image = #imageLiteral(resourceName: "General Tso ")
        } else if (cell.ratingControl.rating == 4) {
            cell.foodLabel?.text = "Sweet and Sour Chicken"
            cell.foodPhoto.image = #imageLiteral(resourceName: "Sweet and Sour")
        } else if (cell.ratingControl.rating == 5){
            cell.foodLabel?.text = "Beef and Brocoli"
            cell.foodPhoto.image = #imageLiteral(resourceName: "Beef and Brocoli")
        } else if (cell.ratingControl.rating == 6){
            cell.foodLabel?.text = "Roast Beef Poboy"
            cell.foodPhoto.image = #imageLiteral(resourceName: "RoastBeefPoboy")
        } else if (cell.ratingControl.rating == 7){
            cell.foodLabel?.text = "Shrimp Poboy"
            cell.foodPhoto.image = #imageLiteral(resourceName: "ShrimpPoboy")
        } else {
            cell.foodLabel?.text = "Catfish Poboy"
            cell.foodPhoto.image = #imageLiteral(resourceName: "CatfishPoboy")
        }
        
        
    }
    
    // Fetches the appropriate student for the data source layout.
    
    if (isSearching) {
        cell.nameLabel?.text = filteredStudents[indexPath.row].name
        cell.IDLabel.text = filteredStudents[indexPath.row].ID
        cell.ratingControl.rating = filteredStudents[indexPath.row].rating
        
        if (filteredStudents[indexPath.row].checked) {
            cell.checkPhoto.image = #imageLiteral(resourceName: "Check")
        } else {
            cell.checkPhoto.image = #imageLiteral(resourceName: "X")
        }
        
        
        setupFoodLabel()
    } else {
        cell.nameLabel.text = students[indexPath.row].name
        cell.IDLabel.text = students[indexPath.row].ID
        cell.ratingControl.rating = students[indexPath.row].rating
        
        printStudentsCheck();
        
        if (students[indexPath.row].checked) {
            cell.checkPhoto.image = #imageLiteral(resourceName: "Check")
        } else {
            cell.checkPhoto.image = #imageLiteral(resourceName: "X")
        }
        
        setupFoodLabel()
    }

    return cell
  }

  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true;
  }
    
  //checkmark code
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.tableView.cellForRow(at: indexPath) as! MealTableViewCell
        
        if (!isSearching) {
        if (students[indexPath.row].checked == false) {
            students[indexPath.row].checked = true
            cell.checkPhoto.image = #imageLiteral(resourceName: "Check")
        } else {
            students[indexPath.row].checked = false;
            cell.checkPhoto.image = #imageLiteral(resourceName: "X")
        }
        } else {
            if (filteredStudents[indexPath.row].checked == false) {
                filteredStudents[indexPath.row].checked = true
                cell.checkPhoto.image = #imageLiteral(resourceName: "Check")
            } else {
                filteredStudents[indexPath.row].checked = false;
                cell.checkPhoto.image = #imageLiteral(resourceName: "X")
            }
        }
        
        print(students[indexPath.row].checked)
        
    }

  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    print("at: \(indexPath.row)") // Debug
    if editingStyle == .delete {
      // Delete the row from the data source
      students.remove(at: indexPath.row)
      saveStudents()
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
    print("from: \(fromIndexPath.row), to: \(toIndexPath.row)") // Debug
    let student = students.remove(at: fromIndexPath.row)
    students.insert(student, at: toIndexPath.row)
    saveStudents()
  }

  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let StatsViewController = segue.destination as? StatsViewController {
    
    var i = 0
    for _ in students {
        
        if (students[i].checked) {
            StatsViewController.checks += 1
        } else {
            StatsViewController.notCheckeds += 1
        }
        //Total Meal counts
        //Meals Left
        if (students[i].rating == 6 && students[i].checked == false) {
            StatsViewController.roastLefts += 1;
            StatsViewController.beefStudents.append(students[i].name)
        }
        if (students[i].rating == 7 && students[i].checked == false) {
            StatsViewController.shrimpLefts += 1;
        }
        if (students[i].rating == 8 && students[i].checked == false) {
            StatsViewController.catfishLefts += 1;
        }
        
        StatsViewController.studentsS = students.count
        
        i += 1
    }
    }
    
  }

  // MARK: Actions
    
    

  @IBAction func unwindToMealList(_ sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController, let student = sourceViewController.student {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing student.
        students[selectedIndexPath.row] = student
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      }
      else {
        // Add a new student.
        let newIndexPath = IndexPath(row: students.count, section: 0)
        students.append(student)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
      }
      // Save the students.
      saveStudents()
    }
  }
    
    // to stats view
    
    

  // MARK: NSCoding

  func saveStudents() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(students, toFile: Student.ArchiveURL.path)
    if !isSuccessfulSave {
      print("Failed to save students...")
    }
    printStudents() // Debug
  }

  func loadStudents() -> [Student]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Student.ArchiveURL.path) as? [Student]
  }
    
    //search bar action
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text == nil) {
            view.endEditing(true);
        }
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            
            tableView.reloadData()
        } else {
            print("Searching........")
            isSearching = true
            
            filteredStudents = students.filter({student -> Bool in
                guard let text = searchBar.text else {return false}
                return student.ID.contains(text) || student.name.contains(text)})
            
            tableView.reloadData()
        }
    }
    
    //keyboard enter action
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true);
    }

}
