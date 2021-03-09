//
//  Storyboarded.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
