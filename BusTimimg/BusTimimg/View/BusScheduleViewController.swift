//
//  ViewController.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 09/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var routeInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 150)
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var routeTimingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var routeInfoViewModel = BusDetailViewModel()
    private var routeTimingViewModel = RouteTimingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        styleViews()
        
        routeInfoViewModel.fetchRouteInfo {
            DispatchQueue.main.async {
                self.routeInfoCollectionView.reloadData()
            }
        }
        
        routeTimingViewModel.fetchRouteTiming {
            DispatchQueue.main.async {
                self.routeTimingTableView.reloadData()
            }
        }
        
    }
    
}

extension ViewController {
    
    private func setupViews() {
        routeInfoCollectionView.register(BusInfoCollectionViewCell.self, forCellWithReuseIdentifier: BusInfoCollectionViewCell.reuseIdentifier)
        
        routeInfoCollectionView.delegate = self
        routeInfoCollectionView.dataSource = self
        
        routeTimingTableView.register(BusTimingTableViewCell.self, forCellReuseIdentifier: String(describing: BusTimingTableViewCell.self))
        routeTimingTableView.delegate = self
        routeTimingTableView.dataSource = self
    }
    
    private func styleViews() {
        self.view.addSubview(routeInfoCollectionView)
        NSLayoutConstraint.activate([
            routeInfoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            routeInfoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            routeInfoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            routeInfoCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        self.view.addSubview(routeTimingTableView)
        NSLayoutConstraint.activate([
            routeTimingTableView.topAnchor.constraint(equalTo: routeInfoCollectionView.bottomAnchor, constant: 8),
            routeTimingTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            routeTimingTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            routeTimingTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        routeTimingTableView.separatorStyle = .none
        
    }
    
}

// MARK:- CollectionViewDelegates
extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if routeTimingViewModel.isEmpty(), routeInfoViewModel.getSelectedCellIndex() == nil {
            let centerIndex = routeInfoViewModel.numberOfItemsInSection() / 2
            let indexPath = IndexPath(item: centerIndex, section: 0)
            routeInfoViewModel.selectCell(at: indexPath)
            let routeID = routeInfoViewModel.midCellRouteID()
            routeTimingViewModel.addRouteTimings(routeID: routeID)
            routeInfoCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.routeTimingTableView.reloadData()
        } else {
            guard let indexPath = routeInfoViewModel.getSelectedCellIndex() else { return }
            routeInfoCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BusInfoCollectionViewCell
        routeTimingViewModel.removeAllPresentRouteTimings()
        routeTimingViewModel.addRouteTimings(routeID: cell.routeID)
        routeInfoViewModel.selectCell(at: indexPath)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.routeTimingTableView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routeInfoViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusInfoCollectionViewCell.reuseIdentifier, for: indexPath) as! BusInfoCollectionViewCell
        cell.configure(cellViewModel: routeInfoViewModel.getCellModel(at: indexPath))
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeTimingViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusTimingTableViewCell.reuseIdentifier, for: indexPath) as! BusTimingTableViewCell
        cell.configure(cellViewModel: routeTimingViewModel.getCellModel(at: indexPath))
        return cell
    }
}
