//
//  LikeFilmController.swift
//  Filmstagram
//
//  Created by Xcode on 30.10.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//

import UIKit

class LikeFilmController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var films = [Search]();
    let _SqlHelper = SQLHelper();
    
    @IBOutlet weak var LikeTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCell") as?
                   LikeFilmCell else { return UITableViewCell() }
               cell.frame.size.height=250;
               cell.LikeFilmTitle.text = films[indexPath.row].title
               cell.LikeFilmYear.text = films[indexPath.row].year
               if let imageURL = URL(string: films[indexPath.row].poster!) {
                   DispatchQueue.global().async {
                       let data = try? Data(contentsOf: imageURL)
                       if let data = data {
                           let image = UIImage(data: data)
                           DispatchQueue.main.async {
                               cell.LikeFilmPoster.image = image
                           }
                       }
                   }
               }
               return cell
    }
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad();
        LikeTableView.dataSource = self
               LikeTableView.delegate = self
        films = self._SqlHelper.read()
                  
              self.LikeTableView.reloadData()

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
