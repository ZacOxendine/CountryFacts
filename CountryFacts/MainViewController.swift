//
//  MainViewController.swift
//  CountryFacts
//
//  Created by Zachary Oxendine on 9/16/20.
//  Copyright © 2020 Zachary Oxendine. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Countries"
        performSelector(inBackground: #selector(restCountriesJSON), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryVC = CountryViewController()
        countryVC.country = countries[indexPath.row]
        navigationController?.pushViewController(countryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: "Country Cell", for: indexPath)
        let country = countries[indexPath.row]
        
        countryCell.textLabel?.text = country.name
        countryCell.textLabel?.numberOfLines = 0
        countryCell.accessoryType = .disclosureIndicator
        
        return countryCell
    }
    
    func restCountriesParse(json: Data) {
        let jsonDecoder = JSONDecoder()
        
        if let jsonData = try? jsonDecoder.decode([Country].self, from: json) {
            countries = jsonData
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func restCountriesJSON() {
        let urlString = "https://restcountries.eu/rest/v2/all"
        
        if let restCountriesURL = URL(string: urlString) {
            if let restCountriesData = try? Data(contentsOf: restCountriesURL) {
                restCountriesParse(json: restCountriesData)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError() {
        let showErrorAC = UIAlertController(title: "Loading Error", message: """
                                            There was a problem loading the feed;
                                            please check your connection.
                                            """, preferredStyle: .alert)
        
        showErrorAC.addAction(UIAlertAction(title: "Okay", style: .default))
        present(showErrorAC, animated: true)
    }
}
