//
//  MainView.swift
//  BasicCoreData
//
//  Created by David Molina on 12/08/22.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Private UI Properties
    
    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Basic Core Data"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var crudButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new country", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(crudButtonAction), for: .touchUpInside)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 6
        return button
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.name)
        return tableView
    }()
    
    // MARK: - Internal Observable Properties
    
    var didSelectCrudButton: Observable<Void> {
        didSelectCrudButtonMutable
    }
    
    // MARK: - Private Observable Properties
    
    private var didSelectCrudButtonMutable = MutableObservable<Void>()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func setTableViewDelegates(_ delegate: UITableViewDelegate, _ datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }

    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(crudButton)
        containerStackView.addArrangedSubview(tableView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        // containerStackView
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // titleLabel
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        // crudButton
        crudButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        crudButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        crudButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc
    private func crudButtonAction(sender: UIButton!) {
        didSelectCrudButtonMutable.postValue(())
    }

}
