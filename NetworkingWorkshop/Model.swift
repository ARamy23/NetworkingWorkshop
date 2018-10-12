//
//  Model.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import Foundation

struct Timeline: Codable {
    let date, text, image: String?
    let user: String?
    let id: Int?
}

struct User: Codable {
}
