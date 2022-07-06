//
//  MovementsController.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import UIKit

class MovementsController: UIViewController {
    
    // Day Balance View
    @IBOutlet weak var view_dayBalance: UIView!                 // Corner radius = 20, white
    @IBOutlet weak var lbl_dayBalanceTitle: UILabel!            // FontSze = 24, Semi Bold, black, Helvetica
    @IBOutlet weak var lbl_dayBalanceMoney: UILabel!            // FontSze = 36, Light , black, Helvetica
    @IBOutlet weak var lbl_dayBalanceCompYesterday: UILabel!    // FontSze = 16, Regular , (158,191,131), Helvetica
    @IBOutlet weak var lbl_dayBalanceComp2days: UILabel!        // FontSze = 16, Regular , (255,139,139), Helvetica
    @IBOutlet weak var btn_DayBalancePlus: UIButton!            // Corner radius = height / 2, (72,129,215)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    

}
