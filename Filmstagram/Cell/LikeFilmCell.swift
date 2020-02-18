//
//  LikeFilmCell.swift
//  Filmstagram
//
//  Created by Xcode on 30.10.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//
import UIKit
class LikeFilmCell: UITableViewCell {
    @IBOutlet weak var LikeFilmTitle: UILabel!
    @IBOutlet weak var LikeFilmYear: UILabel!
    @IBOutlet weak var LikeFilmPoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
