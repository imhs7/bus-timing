//
//  RouteInfoCellViewModel.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 09/08/21.
//

import Foundation

class RouteInfoCellViewModel: NSObject {
    
    let routeID: String?
    let routeName: String?
    let routeSourceStation: String?
    let routeTripDuration: String?
    let routeDestination: String?
    
    init(with model: RouteInfo?) {
        self.routeID = model?.id
        self.routeName = model?.name
        self.routeSourceStation = model?.source
        self.routeTripDuration = model?.tripDuration
        self.routeDestination = model?.destination
    }
}
