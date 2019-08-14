//
//  Helper.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import Foundation

/** To get error from error code */
public var getWebServiceError: (Int?) -> BookssAppErrors? = { (errorCode) in
    
    guard errorCode != nil else {
        return nil
    }
    
    guard let error = BookssAppErrors(rawValue: errorCode!) else {
        return BookssAppErrors.Unknown
    }
    
    return error
    
}
