//
//  TableViewCell.swift
//  Filmstagram
//
//  Created by Xcode on 30.10.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var SearchFilmTitleLabel: UILabel!
    @IBOutlet weak var SearchFilmYearLabel: UILabel! 
    @IBOutlet weak var SearchFilmPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    
    }

}
