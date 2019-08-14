//
//  TableViewHelper.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import Foundation
import UIKit


public protocol ConfigurableCell {
    associatedtype T
    func configure(data: T)
}

public protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}


public class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.T == DataType, CellType: UITableViewCell {
    public static var reuseId: String { return String(describing: CellType.self) }
    
    let data: DataType
    
    public init(data: DataType) {
        self.data = data
    }
    
    public func configure(cell: UIView) {
        (cell as! CellType).configure(data: data)
    }
}
