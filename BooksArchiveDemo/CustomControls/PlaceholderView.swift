//
//  PlaceholderView.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

public enum PlaceholderType {
    case noInternet, somethingWentWrong, noResult
    
    public func getImageAndMessage() -> (UIImage?, String) {
        
        switch self {
        case .noInternet:
            return (nil, "No Internet Connection")
        case .noResult:
            return (nil, "No Result.")
        default:
            return (nil, "Something went wrong")
        }
        
    }
}

import UIKit

@IBDesignable
public class PlaceholderView: UIView {
    
    @IBInspectable var placeholderTextColor: UIColor = UIColor.lightGray {
        didSet {
            messageLabel.textColor = placeholderTextColor
        }
    }
    
    public var type: PlaceholderType? = .somethingWentWrong {
        didSet {
            
            let value = type?.getImageAndMessage()
            self.messageLabel.text = value?.1 ?? ""
        }
    }
    
    // MARK: UIObjects
    private lazy var messageLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: self.frame.width, height: 50)
        lbl.textColor = UIColor.lightGray
        lbl.textAlignment = .center
        lbl.center = self.center
        return lbl
        
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.addSubview(messageLabel)
    }
    
}

