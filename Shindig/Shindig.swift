//
//  Shindig.swift
//  Shindig
//
//  Created by Ryann Consalo on 2017/06/20.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import Foundation


class Shindig {
    
    var host: String?
    var key : String?
    var date : String?
    var totalPool : Int?
    var invited = [String]()
    var coming = [String]()
    var location : String?
    var price : Int?
    var supplies = [String]()
    var time : String?
    
    init? (host: String?, date: String?, location: String?, price: Int?, time: String?) {
        self.host = host
        self.date = date
        self.location = location
        self.price = price
        self.time = time
        self.totalPool = 0
    }
    
    
    
}
