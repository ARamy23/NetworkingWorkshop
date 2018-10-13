//
//  ServerPath.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import Foundation

struct ServerPath
{
    static let baseURL = URL(string: "https://nodeswiftcairo.herokuapp.com/api")!
    static let timelines = "/timelines"
    static let users = "/users"
}
