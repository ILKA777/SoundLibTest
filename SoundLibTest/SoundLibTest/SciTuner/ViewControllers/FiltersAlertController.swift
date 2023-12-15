//
//  FiltersAlertController.swift
//  SciTuner
//
//  Created by Denis Kreshikhin on 17.03.15.
//  Copyright (c) 2015 Denis Kreshikhin. All rights reserved.
//

import Foundation
import UIKit

protocol FiltersAlertControllerDelegate: AnyObject {
    func didChange(filter: Filter)
}

class FiltersAlertController: UIAlertController {
    weak var parentDelegate: FiltersAlertControllerDelegate?
    
    override func viewDidLoad() {
        Filter.allFilters.forEach { self.add(filter: $0) }
        
        addAction(UIAlertAction(title: "cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
    }
    
    func add(filter: Filter){
        let action = UIAlertAction(
            title: filter.localized(), style: UIAlertAction.Style.default,
            handler: {(action: UIAlertAction) -> Void in
                self.parentDelegate?.didChange(filter: filter)
        })
        
        addAction(action)
    }
}
