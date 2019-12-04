//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Lucas Deane on 18.08.18
//  Copyright © 2018 Lucas Deane. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var foodLabel: UILabel!    
    @IBOutlet weak var foodPhoto: UIImageView!
    @IBOutlet weak var checkPhoto: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  }

}
