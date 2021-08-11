//
//  BusInfoCollectionViewCell.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 11/08/21.
//

import UIKit

class BusInfoCollectionViewCell: UICollectionViewCell {
    
    public var routeID: String = ""
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CustomFont-Light", size: 24)
        return label
    }()
    
    private lazy var sourceDestinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CustomFont-Light", size: 24)
        return label
    }()
    
    private lazy var tripDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CustomFont-Light", size: 24)
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            if isSelected == false {
                self.contentView.backgroundColor = .systemTeal
            } else {
                self.contentView.backgroundColor = .yellow
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BusInfoCollectionViewCell {
    
    private func setupViews() {
        
        styleContentView()
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        addSubview(sourceDestinationLabel)
        NSLayoutConstraint.activate([
            sourceDestinationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            sourceDestinationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        addSubview(tripDurationLabel)
        NSLayoutConstraint.activate([
            tripDurationLabel.topAnchor.constraint(equalTo: sourceDestinationLabel.bottomAnchor, constant: 8),
            tripDurationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func styleContentView() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    public func configure(cellViewModel: RouteInfoCellViewModel) {
        routeID = cellViewModel.routeID
        nameLabel.text = cellViewModel.routeName
        sourceDestinationLabel.text = "\(cellViewModel.routeSourceStation)-\(cellViewModel.routeDestination)"
        tripDurationLabel.text = cellViewModel.routeTripDuration
    }
    
}

extension BusInfoCollectionViewCell: Reusable {}
