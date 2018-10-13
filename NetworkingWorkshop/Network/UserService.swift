//
//  UserService.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/13/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import Moya


enum UserService
{
    case currentUser(id: Int)
    case all
}

extension UserService: TargetType
{
    var baseURL: URL {
        return ServerPath.baseURL
    }
    
    var path: String {
        switch self
        {
        case .currentUser(id: let id):
            return ServerPath.users + "/\(id)"
        case .all:
            return ServerPath.users
        }
    }
    
    var method: Moya.Method {
        switch self
        {
        case .currentUser(id: _):
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self
        {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
