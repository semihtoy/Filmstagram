//  ViewController.swift
//  Filmstagram
//  Created by Xcode on 30.10.2019.
//  Copyright © 2019 Xcode. All rights reserved.
import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var films = [Search]();
    var selectedFilm : Search?;
    @IBOutlet weak var SearchTableView: UITableView!;
    @IBOutlet weak var SearchTextField: UITextField!
    let _searchService = SearchService();
    let _SqlHelper = SQLHelper();
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as?
            SearchTableViewCell else { return UITableViewCell() }
        cell.frame.size.height=250;
        cell.SearchFilmTitleLabel.text = films[indexPath.row].title
        cell.SearchFilmYearLabel.text = films[indexPath.row].year
        if let imageURL = URL(string: films[indexPath.row].poster!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.SearchFilmPoster.image = image
                        
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilm = films[indexPath.row];
        self.performSegue(withIdentifier: "ToDetailFilmSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailFilmSegue" {
            let destinationVC = segue.destination as! DetailFilmController
            destinationVC.selectedFilm = selectedFilm
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let printAction = self.printAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [printAction])
    }
    func printAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "print") {  (action, view, completion) in
            self._SqlHelper.insert(_search: self.films[indexPath.row])
            let alert = UIAlertController(title: "Alert", message: self.films[indexPath.row].title!+" Eklendi", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil));
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        action.title =    "Ekle";
        action.backgroundColor = random()
        return action
    }
    func random() -> UIColor {
        return UIColor(red:   random(),
                       green: random(),
                       blue:  random(),
                       alpha: 1.0)
    }
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    @IBAction func SearchButton(_ sender: Any) {
        self._searchService.search(param: ["s": self.SearchTextField.text!, "type":  "movie"]){ (data) in
            self.films = data;
            DispatchQueue.main.async {
                self.SearchTableView.reloadData();
                self.hideKeyboard();
            };
        }

    }
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad();
        SearchTableView.dataSource = self
        SearchTableView.delegate = self
        loginButton.layer.borderWidth = 1
        loginButton.layer.masksToBounds = false
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius =   loginButton.frame.height/2;
        loginButton.clipsToBounds = true
        SearchTextField.layer.borderWidth = 1
        SearchTextField.layer.masksToBounds = false
        SearchTextField.layer.borderColor = UIColor.blue.cgColor
        SearchTextField.layer.cornerRadius =   SearchTextField.frame.height/2;
        SearchTextField.clipsToBounds = true
        self.hideKeyboard()
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

