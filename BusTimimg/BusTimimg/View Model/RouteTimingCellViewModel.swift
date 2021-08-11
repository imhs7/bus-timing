//
//  RouteTimingCellViewModel.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 09/08/21.
//

import UIKit

class RouteTimingCellViewModel: NSObject {
    
    let totalSeats: Int
    let availableSeats: Int
    let tripStartTime: String
        
    init(with model: RouteTiming!) {
        self.totalSeats = model!.totalSeats
        self.availableSeats = model!.avaiable
        self.tripStartTime = model!.tripStartTime
    }
}
