//
//  LoopBack Service.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import Foundation
import Moya

enum TimelineService
{
    case getAll
    
}

extension TimelineService: TargetType
{
    var baseURL: URL {
        return URL(string: ServerPath.baseURL)!
    }
    
    var path: String {
        switch self
        {
        case .getAll:
            return ServerPath.timelines
        }
    }
    
    var method: Moya.Method {
        switch self
        {
        case .getAll:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self
        {
        case .getAll:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self
        {
        case .getAll:
            return nil
        }
    }
    
    
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
