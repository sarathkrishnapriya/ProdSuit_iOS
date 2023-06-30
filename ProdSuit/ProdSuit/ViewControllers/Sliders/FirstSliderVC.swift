//
//  FirstSliderVC.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import UIKit

class FirstSliderVC: UIViewController {
    
    
    //MARK: - VARIABLE
    var index = 0
    // MARK: - OUTLETS
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var sliderTitleLabel: UILabel!
    @IBOutlet weak var sliderDetailLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let info = onBoardDetailsList[index]
        sliderImageView.image = UIImage(named: info.image)
        sliderTitleLabel.text = info.title
        sliderDetailLabel.text = info.details
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
