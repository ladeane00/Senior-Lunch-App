//
//  Student.swift
//  FoodTracker
//
//  Created by Lucas Deane on 18.08.18
//  Copyright © 2018 Lucas Deane. All rights reserved.
//

//import Foundation
import UIKit

class Student: NSObject, /* protocol */ NSCoding {

    // MARK: Properties

    var name: String
    var ID: String
    var rating: Int
    var checkPhoto: UIImage?
    var checked: Bool = false

    // MARK: Archiving Paths

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("students")

    // MARK: Types

    struct PropertyKey {
        static let nameKey = "name"
        static let IDKey = "ID"
        static let ratingKey = "rating"
        static let checkedKey = "checked"
    }

    // MARK: Initialization

    init?(name: String, ID: String, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.ID = ID
        self.rating = rating
    
    super.init() // Call superclass initializer

    // Initialization should fail if there is no name or if the rating is out of range.
    if name.isEmpty || ID.isEmpty || rating < 0 || rating > 8 {
        return nil
    }
  }

    // MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(ID, forKey: PropertyKey.IDKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
        aCoder.encode(checked, forKey: PropertyKey.checkedKey)
  }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        let ID = aDecoder.decodeObject(forKey: PropertyKey.IDKey) as! String
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)

        // Must call designated initializer.
        self.init(name: name, ID: ID, rating: rating)
    }

}
