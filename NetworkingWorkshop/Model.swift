//
//  Model.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import Foundation
import Moya

struct Timeline: Codable {
    let date, text, image: String?
    let user: String?
    let id: Int?
    
    
}

class User: Codable {
    
    let id: Int?
    
    static var currentUser: User?
    {
        get
        {
            if let user = UserDefaults.standard.currentUser()
            {
                return user
            }
            else
            {
                //TODO:- Implement fetch currentUser later
                print("no current user")
                return nil
            }
        }
        
        set
        {
            do
            {
                let encodedCurrentUser = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(encodedCurrentUser, forKey: UserDefaults.currentUserKey)
            }
            catch let err
            {
                print(err)
            }
        }
    }
}

extension UserDefaults
{
    static let currentUserKey = "CurrentUserKey"
    
    func currentUser() -> User?
    {
        guard let currentUserData = data(forKey: UserDefaults.currentUserKey) else { return nil }
        do
        {
            let currentUser = try JSONDecoder().decode(User.self, from: currentUserData)
            return currentUser
        }
        catch let err
        {
            print(err)
            return nil
        }
    }
}
