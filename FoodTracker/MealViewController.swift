//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Lucas Deane on 18.08.18
//  Copyright © 2018 Lucas Deane. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, /* protocols */ UITextFieldDelegate, UINavigationControllerDelegate {

  // MARK: Properties

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var studentIDField: UITextField!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!

  /*
   This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
   or constructed as part of adding a new meal.
   */
  var student: Student?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Handle the text field’s user input through delegate callbacks.
    nameTextField.delegate = self
    studentIDField.delegate = self

    // Set up views if editing an existing Meal.
    if let student = student {
      navigationItem.title = student.name

      nameTextField.text = student.name
      studentIDField.text = student.ID
      ratingControl.rating = student.rating
    }

    // Enable the Save button only if the text field has a valid Meal name.
    checkValidStudentName()
    checkValidID()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

    func checkValidStudentName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func checkValidID() {
        // Disable the Save button if the text field is empty.
        let text = studentIDField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save button while editing.
    saveButton.isEnabled = false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    //mealNameLabel.text = textField.text
    checkValidStudentName()
    checkValidID()
    navigationItem.title = textField.text
  }

  // MARK: Navigation

  @IBAction func cancel(_ sender: UIBarButtonItem) {
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddMealMode = presentingViewController is UINavigationController

    if isPresentingInAddMealMode {
      dismiss(animated: true, completion: nil)
    }
    else {
      navigationController!.popViewController(animated: true)
    }
  }

  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let s = sender as? UIBarButtonItem { // M.Ban Swift 2 --> Swift 3
      if saveButton === s {
        let name = nameTextField.text ?? ""
        let ID = studentIDField.text ?? ""
        let rating = ratingControl.rating

        // Set the meal to be passed to MealTableViewController after the unwind segue.
        student = Student(name: name, ID: ID, rating: rating)
      }
    }
  }

}
