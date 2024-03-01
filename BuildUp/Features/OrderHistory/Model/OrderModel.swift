//
//  OrderModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation
import ObjectMapper

class OrderModel: Mappable {
    
    var uuid: String?
    var status: String?
    var paymentMethod: String?
    var paymentMethodImage: String?
    var createdAt: String?
    var formattedTotal: FormatedPriceModel?
    var formattedSubtotal: FormatedPriceModel?
    var formattedSubtotalBeforeDiscount: FormatedPriceModel?
    var formattedTotalShippingCost: FormatedPriceModel?
    var formattedTotalTax: FormatedPriceModel?
    var products: [ProductModel]?
    var orderTaxes: [TaxDetailsModel]?
    
    var customerEmail: String?
    var customerPhone: String?
    var customerCountryCode: String?
    var customerName: String?
    var statusLabel: String?
    var shippingCountry: CountryModel?
    var shippingCity: CityModel?
    var shippingArea: AreaModel?
    var shippingAddressDescription: String?
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        status <- map["status"]
        paymentMethod <- map["payment_method"]
        paymentMethodImage <- map["payment_method_image"]
        createdAt <- map["created_at"]
        formattedTotal <- map["formatted_total"]
        products <- map["products"]
        orderTaxes <- map["order_taxes"]
        
        customerEmail <- map["customer_email"]
        customerPhone <- map["customer_phone"]
        customerCountryCode <- map["customer_country_code"]
        customerName <- map["customer_name"]
        formattedSubtotal <- map["formatted_subtotal"]
        formattedSubtotalBeforeDiscount <- map["formatted_subtotal_before_discount"]
        formattedTotalShippingCost <- map["formatted_total_shipping_cost"]
        formattedTotalTax <- map["formatted_total_tax"]
        
        statusLabel <- map["status_label"]
        shippingCountry <- map["shipping_country"]
        shippingCity <- map["shipping_city"]
        shippingArea <- map["shipping_area"]
        shippingAddressDescription <- map["shipping_address_description"]
    }
    
    required init?(map: Map) {

    }
}
