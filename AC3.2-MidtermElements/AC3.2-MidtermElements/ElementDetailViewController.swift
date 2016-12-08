//
//  ElementDetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Edward Anchundia on 12/8/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    var element: Elements?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = element?.name
        symbolLabel.text = "Symbol: \(element!.symbol!)"
        numberLabel.text = " \(element!.number!)"
        weightLabel.text = "\(element!.weight!)"
        meltingPointLabel.text = "Melting Point: \(element!.meltingC!) C"
        boilingPointLabel.text = "Boiling Point: \(element!.boilingC!) C"
        nameLabel.text = "\(element!.name!)"
        
        getImage()
    }
    
    func getImage() {
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(element!.symbol!).png") { (data: Data?) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.imageView.image = validImage
                }
            }
        }
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let postPar = ["my_name": "Edward Anchundia", "favorite_element": element!.symbol!]
        APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", data: postPar)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
