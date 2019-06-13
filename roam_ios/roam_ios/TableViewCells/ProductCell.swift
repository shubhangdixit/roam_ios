//
//  ProductCell.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 12/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    var product : RoamProducts?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 6
        
    }
    
    func configureCell() {
        titleLabel.text = product?.name
        descriptionLabel.text = product?.productDescription
        priceLabel.text = product?.getProductPrice()
        if let url = product?.imageUrl {
        productImageView.loadImageUsingCache(withUrl: url)
        }
    }

}
