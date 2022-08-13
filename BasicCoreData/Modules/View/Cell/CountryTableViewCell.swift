//
//  UserTableViewCell.swift
//  BasicCoreData
//
//  Created by David Molina on 12/08/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    static let name = String(describing: CountryTableViewCell.self)
    
    // MARK: - Private UI Properties
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Internal Properties
    
    var countryName: String? {
        didSet {
            setupCell()
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        // titleLabel
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
    }
    
    private func setupCell() {
        titleLabel.text = countryName
    }
    
}
