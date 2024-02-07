//
//  SummaryModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class SummaryModel: Mappable {
    
    var subtotalBeforeDiscount: FormatedPriceModel?
    var taxDetails: [TaxDetailsModel]?
    var shippingDetails: ShippingDetailsModel?
    var formattedTotal: FormatedPriceModel?
    var formattedSubtotal: FormatedPriceModel?
    var formattedTaxes: FormatedPriceModel?
    var formattedShipping: FormatedPriceModel?
    
    func mapping(map: Map) {
        subtotalBeforeDiscount <- map["subtotal_before_discount"]
        taxDetails <- map["tax_details"]
        shippingDetails <- map["shipping_details"]
        formattedTotal <- map["formatted_total"]
        formattedSubtotal <- map["formatted_subtotal"]
        formattedTaxes <- map["formatted_taxes"]
        formattedShipping <- map["formatted_shipping"]
    }
    
    required init?(map: Map) {

    }
}
