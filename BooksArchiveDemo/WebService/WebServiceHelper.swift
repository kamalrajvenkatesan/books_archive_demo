//
//  WebServiceHelper.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import Foundation
import Alamofire

public struct RouteDetails {
    var path: String
    var method: HTTPMethod
    var encoding: ParameterEncoding
}

public enum ApiRoute {
    case getAllBooks
    
    public func getDetails() -> RouteDetails {
        // Use Switch Statement for more than one api route
        return RouteDetails(path: "http://android.jiny.mockable.io/getAll", method: .get, encoding: JSONEncoding.default)
    }
}


public enum BookssAppErrors: Int {
    case NoInternet = -1009
    case NotFound = 404
    case ValidationError = 422
    case InternalServerError = 500
    case Unknown = 0
    
    var getMessage: String {
        switch self {
        case .NoInternet:
            return "Not able to reach, Kindly check the internet connection."
        default:
            return "Something went wrong"
        }
    }
}


