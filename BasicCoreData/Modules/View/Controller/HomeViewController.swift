//
//  MainViewController.swift
//  BasicCoreData
//
//  Created by David Molina on 12/08/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    // MARK: - Private UI properites
       
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.setTableViewDelegates(adapter, adapter)
        return view
    }()
       
    // MARK: - Internal Properties
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
    // MARK: - Private Properties
    
    private var adapter = HomeAdapter()
       
    // MARK: - Initializers
       
    init() {
        super.init(nibName: nil, bundle: nil)
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle ViewController Methods
       
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        fetchCountries()
    }

    // MARK: - Private Methods
    
    private func setupBindings() {
        adapter.didSelectRowAt.observe { [unowned self] country in
            self.editCountry(editCountry: country)
        }
        adapter.didSelectRowToDelete.observe { [unowned self] country in
            self.deleteCountry(country: country)
        }
        homeView.didSelectCrudButton.observe { [unowned self] _ in
            self.addCountry()
        }
    }
    
    private func fetchCountries() {
        do {
            adapter.countries = try context.fetch(Country.fetchRequest())
            DispatchQueue.main.async {
                self.homeView.reloadTableViewData()
            }
        }
        catch {
            print("Has been ocurred error fetching data from CoreData")
        }
        
    }
    
    private func addCountry() {
        let alert = UIAlertController(title: "New Country!", message: "Enter the name of the new country", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save country", style: .default) { (action) in
            let textField = alert.textFields![0]
            
            let newCountry = Country(context: self.context)
            newCountry.name = textField.text
            
            try! self.context.save()
            
            self.fetchCountries()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func editCountry(editCountry: Country) {
        let alert = UIAlertController(title: "Edit Country!", message: "Enter the new name for this country", preferredStyle: .alert)
        alert.addTextField()
        let textField = alert.textFields![0]
        textField.text = editCountry.name
        
        let saveButton = UIAlertAction(title: "Save changes", style: .default) { (action) in
            let textField = alert.textFields![0]
            
            editCountry.name = textField.text
            
            try! self.context.save()
            
            self.fetchCountries()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func deleteCountry(country: Country) {
        context.delete(country)
        
        try! self.context.save()
        
        fetchCountries()
        
    }

}
