//
//  SearchViewController.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/15/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import ObjectMapper

protocol SearchViewControllerDelegate: class {
    func getCity(city: City)
}

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var cites: [City] = []
    var citesSearchResult: [City] = []
    var isEditingSearch = false
    private let searchTableViewCell = "SearchTableViewCell"
    
    // MARK: - Delegate
    weak var delegate: SearchViewControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
       
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        DispatchQueue(label: "background").async {
            if let cites = GlobalCites.cites {
                self.cites = cites
            } else {
                self.parseCityListJson()
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Filter
    func filterContent(_ searchText : String) {
        citesSearchResult = cites.filter({(myList : City) -> Bool in
            let nameMatch = myList.name?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let countryMatch = myList.country?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return nameMatch != nil || countryMatch  != nil
        })
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Parse local json file
    func parseCityListJson() {
        if let path = Bundle.main.path(forResource: "city.list.min", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let parsedCites = Mapper<City>().mapArray(JSONObject: jsonResult)
                guard let cites = parsedCites else { return }
                self.cites = cites
                GlobalCites.cites = cites
            } catch let error {
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citesSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCell, for: indexPath) as? SearchTableViewCell
        cell?.city = citesSearchResult[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCity(city: citesSearchResult[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, searchText != "" {
            isEditingSearch = true
            filterContent(searchText)
        } else {
            isEditingSearch = false
            citesSearchResult.removeAll()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        isEditingSearch = false
        citesSearchResult.removeAll()
        tableView.reloadData()
    }
}
