//
//  ActivityIndicator.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/10/21.
//

import UIKit

extension UIView {
    func activityIndicator(style: UIActivityIndicatorView.Style, frame: CGRect? = nil, center: CGPoint? = nil) -> UIActivityIndicatorView {
        let activityViewIndicator = UIActivityIndicatorView(style: style)
        
        if let frame = frame {
            activityViewIndicator.frame = frame
        }
        
        if let center = center {
            activityViewIndicator.center = center
        }
        
        return activityViewIndicator
    }
}
