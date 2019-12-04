//
//  SearchesTableViewCell.swift
//  CNNAssessment
//
//  Created by Ronald Jones on 11/26/19.
//  Copyright © 2019 Ron Jones Jr. All rights reserved.
//

import UIKit

class SearchesTableViewCell: UITableViewCell {
    //set outlets
    @IBOutlet weak var searchText: UILabel!
    @IBOutlet weak var goArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
