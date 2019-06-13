//
//  ProductListsViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 13/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit

class ProductListsViewController: RoamBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var productTableView: UITableView!
    
    @IBOutlet weak var topSpaceConstraintForFilterView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomSpaceConstraintForFilterview: NSLayoutConstraint!
    
    let kMenuViewMaximumHeight : CGFloat = 650.0
    let kMenuViewMinimumHeight : CGFloat = 200.0
    
    var shouldFilter = false
    var products : [RoamProducts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        loadProductList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reSizeFilterView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterView.layer.cornerRadius = 10
        filterView.layer.shadowColor = UIColor.black.cgColor
        filterView.layer.shadowOpacity = 1
        filterView.layer.shadowOffset = CGSize(width: 0, height: 5)
        filterView.layer.shadowRadius = 15
    }
    
    func loadProductList () {
        progressIndicator.startSpinner()
        DataManager.shared.getProductList(success: { (productList) in
            self.products = productList
            DispatchQueue.main.async {
                self.productTableView.reloadData()
                self.progressIndicator.stopSpinner()
            }
        }) {
            self.progressIndicator.stopSpinner()
            self.showAlertMsg(title: "", message: "Error loading products")
        }
    }
    
    func reSizeFilterView () {
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 7, animations: {
            
            self.view.layoutIfNeeded()
        }) { finished in
            self.topSpaceConstraintForFilterView.constant = self.topSpaceConstraintForFilterView.constant + 170
            self.bottomSpaceConstraintForFilterview.constant = self.bottomSpaceConstraintForFilterview.constant - 170
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
            }) { finished in
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
            cell.product = products?[indexPath.row]
            cell.configureCell()
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
