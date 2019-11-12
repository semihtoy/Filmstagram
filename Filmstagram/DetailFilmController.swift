//
//  DetailFilmController.swift
//  Filmstagram
//
//  Created by Xcode on 30.10.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//

import UIKit

class DetailFilmController: UIViewController {
   
    let  _detailService = DetailService();
    var selectedFilm : Search?;
    @IBOutlet weak var FilmDetailPoster: UIImageView!
    @IBOutlet weak var DetailFilmTitle: UILabel!
    @IBOutlet weak var DetailFilmActor: UILabel!
    @IBOutlet weak var DetailFilmİdmb: UILabel!
    @IBOutlet weak var DetailFilmDetail: UITextView!
    @IBAction func FilmSkorTitle(_ sender: Any) {
    }
    @IBOutlet weak var LikeFilmButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self._detailService.getDetail(param: [ "i" : (selectedFilm?.imdbID)!]) { (FilmDetail) in
            
            DispatchQueue.main.async {
                
            
            self.DetailFilmTitle.text = FilmDetail.title
            self.DetailFilmActor.text = FilmDetail.actors
            self.DetailFilmİdmb.text = FilmDetail.imdbVotes
            self.DetailFilmDetail.text = FilmDetail.plot
            if let imageURL = URL(string: FilmDetail.poster!) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.FilmDetailPoster.image = image
                        }
                    }
                }
            }
            
        }
            }
        
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
