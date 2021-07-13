//
//  LoadingViewable.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import UIKit


protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension loadingViewable where Self: UIViewController {
    
    func startAnimating() {
        ProgressHUD.show()
    }
    
    func stopAnimating() {
        ProgressHUD.dismiss()
    }
}
