//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Edward Anchundia on 12/8/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {

    var elements: [Elements] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getData()
    }
    
    func getData() {
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data: Data?) in
            if let validData = data,
                let validElements = Elements.elements(from: validData) {
                    self.elements = validElements
                    self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element", for: indexPath)
        let elements = self.elements[indexPath.row]
        
        cell.textLabel?.text = elements.name
        cell.detailTextLabel?.text = "\(elements.symbol!)(\(elements.number!)) \(elements.weight!)"
        
        if let symbol = elements.symbol {
            APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(symbol)_200.png") { (data: Data?) in
                if let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                    }
                }
            }
        }

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let elementDetail = segue.destination as? ElementDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            elementDetail.element = elements[indexPath.row]
        }
    }

}
