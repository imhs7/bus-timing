//
//  BusDetailViewModel.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 10/08/21.
//

import Foundation

class BusDetailViewModel: NSObject {
    
    let urlString = "https://jsonkeeper.com/b/IX4Q"
    
    var routeInfoArray = [RouteInfo]()
    var routeTimingDetail = [RouteTiming]()
    var routeInfoModel = [RouteInfoCellViewModel]()
    var selectedCellIndex = IndexPath()
    
    public func fetchRouteInfo(completion: @escaping () -> Void){
        Parser<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeInfoArray = result.routeInfo
            completion()
        }
    }
}

extension BusDetailViewModel {
    
    public func numberOfItemsInSection() -> Int {
        routeInfoModel = routeInfoArray.map { RouteInfoCellViewModel(with: $0) }
        return routeInfoArray.count
    }
    
    public func getCellModel(at indexPath: IndexPath) -> RouteInfoCellViewModel {
        return routeInfoModel[indexPath.row]
    }
    
    public func midCellRouteID() -> String {
        let centerIndex = self.numberOfItemsInSection() / 2
        return routeInfoArray[centerIndex].id
    }
    
    
    public func selectCell(at indexPath: IndexPath) {
        selectedCellIndex = indexPath
    }

    public func getSelectedCellIndex() -> IndexPath? {
        if selectedCellIndex.isEmpty {
        return nil
        }
        return selectedCellIndex
    }
}
