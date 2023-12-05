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
    var total: Double?
    var subtotal: Double?
    var status: String?
    var paymentMethod: String?
    var createdAt: String?
    var formattedTotal: FormatedPriceModel?
    var formattedSubtotal: FormatedPriceModel?
    var formattedSubtotalBeforeDiscount: FormatedPriceModel?
    var formattedTotalShippingCost: FormatedPriceModel?
    var formattedTotalTax: FormatedPriceModel?
    var products: [ProductModel]?
    
    var customerEmail: String?
    var customerPhone: String?
    var customerCountryCode: String?
    var customerName: String?
    var totalShippingCost: Double?
    var subtotalBeforeDiscount: Double?
    var totalTax: Double?
    var statusLabel: String?
    var shippingCountry: CountryModel?
    var shippingCity: CityModel?
    var shippingArea: AreaModel?
    var shippingAddressDescription: String?
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        total <- map["total"]
        status <- map["status"]
        paymentMethod <- map["payment_method"]
        createdAt <- map["created_at"]
        formattedTotal <- map["formatted_total"]
        products <- map["products"]
        
        customerEmail <- map["customer_email"]
        customerPhone <- map["customer_phone"]
        customerCountryCode <- map["customer_country_code"]
        customerName <- map["customer_name"]
        subtotal <- map["subtotal"]
        totalShippingCost <- map["total_shipping_cost"]
        subtotalBeforeDiscount <- map["subtotal_before_discount"]
        totalTax <- map["total_tax"]
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
