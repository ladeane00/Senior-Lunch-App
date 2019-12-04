//
//  StatsViewController.swift
//  FoodTracker
//
//  Created by Lucas Deane on 10/21/18.
//  Copyright © 2018 Mario Ban. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    //stats variables
    @IBOutlet weak var students: UILabel!
    @IBOutlet weak var checked: UILabel!
    @IBOutlet weak var notChecked: UILabel!
    @IBOutlet weak var roastBeef: UILabel!
    @IBOutlet weak var shrimp: UILabel!
    @IBOutlet weak var catfish: UILabel!
    
    
    var checks: Int = 0
    var notCheckeds: Int = 0
    var studentsS: Int = 0;
    
    var roastLefts: Int = 0;
    var shrimpLefts: Int = 0;
    var catfishLefts: Int = 0;
    
    var beefStudents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting initial values
        checked.text = "Checked: \(checks)"
        notChecked.text = "Not Checked: \(notCheckeds)"
        students.text = "Total Students: \(studentsS)"
        roastBeef.text = "Roast Beef Left: \(roastLefts)" + "\(beefStudents)"
        shrimp.text = "Shrimp Left: \(shrimpLefts)"
        catfish.text = "Catfish Left: \(catfishLefts)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
