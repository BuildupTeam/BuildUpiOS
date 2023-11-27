//
//  CheckoutPaymentTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerview: UIView!
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    
    var checkoutModel: CheckoutModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
