//
//  AutomationController.swift
//  Money Management
//
//  Created by Igna on 14/07/2022.
//

import UIKit

class AutomationController: UIViewController {
    
    //var product = Product()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = automationTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddMovementController {
            vc.automationProduct = true
        }
    }

}
