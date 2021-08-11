//
//  BusTimingViewModel.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 09/08/21.
//

import Foundation
import UIKit

class RouteTimingViewModel: NSObject {
    
    private let urlString = "https://jsonkeeper.com/b/IX4Q"
    private var routeTimingList = [String: [RouteTiming]]()
    private var routeTimingCellViewModels = [RouteTimingCellViewModel]()
    private var routeTimingArray = [RouteTiming]()
    
    public func fetchRouteTiming(completion: @escaping () -> Void) {
        Parser<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeTimingList = result.routeTimings
            completion()
        }
    }
}


extension RouteTimingViewModel {
    
    public func getCellModel(at indexPath: IndexPath) -> RouteTimingCellViewModel {
        return routeTimingCellViewModels[indexPath.row]
    }
    
    public func numberOfRowsInSection() -> Int {
        routeTimingCellViewModels = routeTimingArray.map{ RouteTimingCellViewModel(with: $0)}
        return routeTimingArray.count
    }
    
    public func isEmpty() -> Bool {
        return routeTimingArray.count == 0
    }
    
    public func removeAllPresentRouteTimings() {
        if routeTimingArray.count > 0 {
            routeTimingArray.removeAll()
        }
        return
    }
    
    public func addRouteTimings(routeID: String) {
        let routes = routeTimingList.filter{ $0.key == routeID }.map{ $0.value }
        for routeTimingArray in routes.map({ $0 }) {
            self.routeTimingArray = routeTimingArray
        }
    }
}
