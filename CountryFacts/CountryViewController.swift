//
//  CountryViewController.swift
//  CountryFacts
//
//  Created by Zachary Oxendine on 9/24/20.
//  Copyright © 2020 Zachary Oxendine. All rights reserved.
//

import UIKit

class CountryViewController: UITableViewController {
    let naString = "N/A"
    var country: Country?
    var facts = [] as [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Facts"
        
        guard let country = country else { return }
        let populationFormatted = longNumberFormatter(longNumber: NSNumber(value: country.population))
        var areaFormatted: String
        if longNumberFormatter(longNumber: NSNumber(value: country.area ?? 0)) == "0" {
            areaFormatted = naString
        } else {
            areaFormatted = "\(longNumberFormatter(longNumber: NSNumber(value: country.area ?? 0))) km²"
        }
        
        let name = country.name
        let capital = "Capital: \(country.capital)"
        let region = "Region: \(country.region)"
        let population = "Population: \(populationFormatted)"
        let area = "Area: \(areaFormatted)"
        
        facts = [name, capital, region, population, area]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Fact Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let factCell = tableView.dequeueReusableCell(withIdentifier: "Fact Cell", for: indexPath)
        factCell.textLabel?.text = facts[indexPath.row]
        factCell.textLabel?.numberOfLines = 0
        
        switch indexPath.row {
            case 0:
                factCell.textLabel?.textAlignment = .center
            default:
                factCell.indentationLevel = 1
        }
        
        return factCell
    }
    
    func longNumberFormatter(longNumber: NSNumber) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let longNumberFormatter = numberFormatter.string(from: longNumber)
        if let longNumberFormatter = longNumberFormatter {
            return longNumberFormatter
        } else {
            return naString
        }
    }
}
