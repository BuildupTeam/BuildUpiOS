//
//  SummaryModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class SummaryModel: Mappable {
    
    var total: Double?
    var subtotal: Double?
    var subtotal_before_discount: Double?
    var taxes: Double?
    var shipping: Double?
    var taxDetails: [TaxDetailsModel]?
    var shippingDetails: ShippingDetailsModel?
    var formattedTotal: FormatedPriceModel?
    var formattedSubtotal: FormatedPriceModel?
    var formattedTaxes: FormatedPriceModel?
    var formattedShipping: FormatedPriceModel?
    

    func mapping(map: Map) {
        total <- map["total"]
        subtotal <- map["subtotal"]
        subtotal_before_discount <- map["subtotal_before_discount"]
        taxes <- map["taxes"]
        shipping <- map["shipping"]
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
