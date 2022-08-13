//
//  HomeAdapter.swift
//  BasicCoreData
//
//  Created by David  Molina on 12/08/22.
//

import UIKit

class HomeAdapter: NSObject {
    
    // MARK: - Internal Properties
    
    var countries: [Country]?
    
    // MARK: - Internal Observable Properties
    
    var didSelectRowAt: Observable<Country> {
        didSelectRowAtMutable
    }
    
    var didSelectRowToDelete: Observable<Country> {
        didSelectRowToDeleteMutable
    }
    
    // MARK: - Private Observable Properties
    
    private var didSelectRowToDeleteMutable = MutableObservable<Country>()
    
    private var didSelectRowAtMutable = MutableObservable<Country>()
    
}

// MARK: - UITableViewDataSource
extension HomeAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countries = countries {
            return countries.count
        } else {
            return 1
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.name) as? CountryTableViewCell else { return UITableViewCell() }
        cell.countryName = countries?[indexPath.row].name
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension HomeAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryToEdit = self.countries![indexPath.row]
        self.didSelectRowAtMutable.postValue(countryToEdit)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let countryToDelete = self.countries![indexPath.row]
            self.didSelectRowToDeleteMutable.postValue(countryToDelete)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
