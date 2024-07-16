//Localized.swift

import Foundation

// swiftlint:disable superfluous_disable_command 
// swiftlint:disable file_length
// swiftlint:disable trailing_whitespace trailing_newline

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
      /// Apple Pay country code is empty!
      internal static var paymentSdkApplePayErrorMissingCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_apple_pay_error_missing_country_code")
      }
      /// Apple Pay identifier is empty!
      internal static var paymentSdkApplePayErrorMissingMerchantIdentifier: String {
        return L10n.tr("Localizable", "payment_sdk_apple_pay_error_missing_merchant_identifier")
      }
      /// Merchant name is empty!
      internal static var paymentSdkApplePayErrorMissingMerchantName: String {
        return L10n.tr("Localizable", "payment_sdk_apple_pay_error_missing_merchant_name")
      }
      /// UnAuthorized Apple Pay networks
      internal static var paymentSdkApplePayErrorUnauthorizedNetworks: String {
        return L10n.tr("Localizable", "payment_sdk_apple_pay_error_unauthorized_networks")
      }
      /// Apple Pay isn't supported on simulator please try on a real device
      internal static var paymentSdkApplePaySimulatorNotSupported: String {
        return L10n.tr("Localizable", "payment_sdk_apple_pay_simulator_not_supported")
      }
      /// City
      internal static var paymentSdkBillingAddressCity: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_city")
      }
      /// Country
      internal static var paymentSdkBillingAddressCountry: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_country")
      }
      /// Email
      internal static var paymentSdkBillingAddressEmail: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_email")
      }
      /// Full Name
      internal static var paymentSdkBillingAddressFullName: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_full_name")
      }
      /// Phone Number
      internal static var paymentSdkBillingAddressPhone: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_phone")
      }
      /// State
      internal static var paymentSdkBillingAddressState: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_state")
      }
      /// Street
      internal static var paymentSdkBillingAddressStree: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_stree")
      }
      /// Zip Code
      internal static var paymentSdkBillingAddressZip: String {
        return L10n.tr("Localizable", "payment_sdk_billing_address_zip")
      }
      /// Billing Details
      internal static var paymentSdkBillingDetails: String {
        return L10n.tr("Localizable", "payment_sdk_billing_details")
      }
      /// Select Country
      internal static var paymentSdkBillingSelectCountry: String {
        return L10n.tr("Localizable", "payment_sdk_billing_select_country")
      }
      /// Cancel
      internal static var paymentSdkCancel: String {
        return L10n.tr("Localizable", "payment_sdk_cancel")
      }
      /// Are you sure you want to cancel the payment?
      internal static var paymentSdkCancelAlert: String {
        return L10n.tr("Localizable", "payment_sdk_cancel_alert")
      }
      /// CAV
      internal static var paymentSdkCardCav: String {
        return L10n.tr("Localizable", "payment_sdk_card_cav")
      }
      /// CAV
      internal static var paymentSdkCardCavHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cav_hint")
      }
      /// CID
      internal static var paymentSdkCardCid: String {
        return L10n.tr("Localizable", "payment_sdk_card_cid")
      }
      /// CID
      internal static var paymentSdkCardCidHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cid_hint")
      }
      /// CVC
      internal static var paymentSdkCardCvc: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvc")
      }
      /// CVC
      internal static var paymentSdkCardCvcHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvc_hint")
      }
      /// CVD
      internal static var paymentSdkCardCvd: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvd")
      }
      /// CVD
      internal static var paymentSdkCardCvdHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvd_hint")
      }
      /// CVN
      internal static var paymentSdkCardCvn: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvn")
      }
      /// CVN
      internal static var paymentSdkCardCvnHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvn_hint")
      }
      /// CVV
      internal static var paymentSdkCardCvv: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvv")
      }
      /// CVV
      internal static var paymentSdkCardCvvHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_cvv_hint")
      }
      /// Card number is empty!
      internal static var paymentSdkCardErrorEmptyCardNumber: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_card_number")
      }
      /// CID is empty!
      internal static var paymentSdkCardErrorEmptyCid: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_cid")
      }
      /// CVC is empty!
      internal static var paymentSdkCardErrorEmptyCvc: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_cvc")
      }
      /// CVN is empty!
      internal static var paymentSdkCardErrorEmptyCvn: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_cvn")
      }
      /// CVV is empty!
      internal static var paymentSdkCardErrorEmptyCvv: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_cvv")
      }
      /// Expiry date is empty!
      internal static var paymentSdkCardErrorEmptyExpiryDate: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_expiry_date")
      }
      /// Card holder name is empty!
      internal static var paymentSdkCardErrorEmptyNameOnCard: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_empty_name_on_card")
      }
      /// Expired credit card
      internal static var paymentSdkCardErrorExpiredExpiryDate: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_expired_expiry_date")
      }
      /// Invalid card number
      internal static var paymentSdkCardErrorInvalidCardNumber: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_card_number")
      }
      /// Invalid CID!
      internal static var paymentSdkCardErrorInvalidCid: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_cid")
      }
      /// Invalid CVC!
      internal static var paymentSdkCardErrorInvalidCvc: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_cvc")
      }
      /// Invalid CVN!
      internal static var paymentSdkCardErrorInvalidCvn: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_cvn")
      }
      /// Invalid CVV!
      internal static var paymentSdkCardErrorInvalidCvv: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_cvv")
      }
      /// Invalid expiry date
      internal static var paymentSdkCardErrorInvalidExpiryDate: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_expiry_date")
      }
      /// Invalid card holder name
      internal static var paymentSdkCardErrorInvalidNameOnCard: String {
        return L10n.tr("Localizable", "payment_sdk_card_error_invalid_name_on_card")
      }
      /// Expiry Date
      internal static var paymentSdkCardExpiryDate: String {
        return L10n.tr("Localizable", "payment_sdk_card_expiry_date")
      }
      /// MM/YY
      internal static var paymentSdkCardExpiryDateHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_expiry_date_hint")
      }
      /// John Smith
      internal static var paymentSdkCardNameOnCardHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_name_on_card_hint")
      }
      /// Name on Card
      internal static var paymentSdkCardNameOnCardTitle: String {
        return L10n.tr("Localizable", "payment_sdk_card_name_on_card_title")
      }
      /// Card Number
      internal static var paymentSdkCardNumber: String {
        return L10n.tr("Localizable", "payment_sdk_card_number")
      }
      /// 0000 0000 0000 0000
      internal static var paymentSdkCardNumberHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_number_hint")
      }
      /// PAY NOW
      internal static var paymentSdkCardPayButton: String {
        return L10n.tr("Localizable", "payment_sdk_card_pay_button")
      }
      /// Not Now
      internal static var paymentSdkCardScannerCameraPermissionDismiss: String {
        return L10n.tr("Localizable", "payment_sdk_card_scanner_camera_permission_dismiss")
      }
      /// Please grant permission to use the Camera so that you can scan cards
      internal static var paymentSdkCardScannerCameraPermissionMessage: String {
        return L10n.tr("Localizable", "payment_sdk_card_scanner_camera_permission_message")
      }
      /// Open Settings
      internal static var paymentSdkCardScannerCameraPermissionSettings: String {
        return L10n.tr("Localizable", "payment_sdk_card_scanner_camera_permission_settings")
      }
      /// Card Scanner
      internal static var paymentSdkCardScannerCameraPermissionTitle: String {
        return L10n.tr("Localizable", "payment_sdk_card_scanner_camera_permission_title")
      }
      /// Line up card within the lines
      internal static var paymentSdkCardScannerLineUpHint: String {
        return L10n.tr("Localizable", "payment_sdk_card_scanner_line_up_hint")
      }
      /// Search
      internal static var paymentSdkCountryListSearch: String {
        return L10n.tr("Localizable", "payment_sdk_country_list_search")
      }
      /// You're paying
      internal static var paymentSdkCreditCardPayAmount: String {
        return L10n.tr("Localizable", "payment_sdk_credit_card_pay_amount")
      }
      /// Cancel
      internal static var paymentSdkCreditCardScreenDismiss: String {
        return L10n.tr("Localizable", "payment_sdk_credit_card_screen_dismiss")
      }
      /// Save card no. for future payments
      internal static var paymentSdkCreditCardScreenSaveCardLabel: String {
        return L10n.tr("Localizable", "payment_sdk_credit_card_screen_save_card_label")
      }
      /// To continue, you have to save the card info!
      internal static var paymentSdkCreditCardScreenSaveCardMandatoryError: String {
        return L10n.tr("Localizable", "payment_sdk_credit_card_screen_save_card_mandatory_error")
      }
      /// Payment Process
      internal static var paymentSdkCreditCardScreenTitle: String {
        return L10n.tr("Localizable", "payment_sdk_credit_card_screen_title")
      }
      /// Done
      internal static var paymentSdkDone: String {
        return L10n.tr("Localizable", "payment_sdk_done")
      }
      /// Failed to scan
      internal static var paymentSdkErrorCardScannerFailed: String {
        return L10n.tr("Localizable", "payment_sdk_error_card_scanner_failed")
      }
      /// Alternative payment methods list is empty
      internal static var paymentSdkErrorEmptyAlternativePaymentMethods: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_alternative_payment_methods")
      }
      /// Billing address is empty!
      internal static var paymentSdkErrorEmptyBillingAddress: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_address")
      }
      /// Billing city is empty!
      internal static var paymentSdkErrorEmptyBillingCity: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_city")
      }
      /// Billing country code is empty!
      internal static var paymentSdkErrorEmptyBillingCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_country_code")
      }
      /// Billing email is empty!
      internal static var paymentSdkErrorEmptyBillingEmail: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_email")
      }
      /// Billing full name is empty!
      internal static var paymentSdkErrorEmptyBillingFullName: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_full_name")
      }
      /// Billing phone number is empty!
      internal static var paymentSdkErrorEmptyBillingPhone: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_phone")
      }
      /// Billing state is empty!
      internal static var paymentSdkErrorEmptyBillingState: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_state")
      }
      /// Billing ZIP code is empty!
      internal static var paymentSdkErrorEmptyBillingZipCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_billing_zip_code")
      }
      /// Shipping address is empty!
      internal static var paymentSdkErrorEmptyShippingAddress: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_address")
      }
      /// Shipping city is empty!
      internal static var paymentSdkErrorEmptyShippingCity: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_city")
      }
      /// Shipping country code is empty!
      internal static var paymentSdkErrorEmptyShippingCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_country_code")
      }
      /// Shipping email is empty!
      internal static var paymentSdkErrorEmptyShippingEmail: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_email")
      }
      /// Shipping full name is empty!
      internal static var paymentSdkErrorEmptyShippingFullName: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_full_name")
      }
      /// Shipping phone number is empty!
      internal static var paymentSdkErrorEmptyShippingPhone: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_phone")
      }
      /// Shipping state is empty!
      internal static var paymentSdkErrorEmptyShippingState: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_state")
      }
      /// Shipping ZIP code is empty!
      internal static var paymentSdkErrorEmptyShippingZipCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_empty_shipping_zip_code")
      }
      /// Something went wrong!
      internal static var paymentSdkErrorGeneric: String {
        return L10n.tr("Localizable", "payment_sdk_error_generic")
      }
      /// Invalid amount
      internal static var paymentSdkErrorInvalidAmount: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_amount")
      }
      /// Invalid billing address
      internal static var paymentSdkErrorInvalidBillingAddress: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_address")
      }
      /// Invalid billing city
      internal static var paymentSdkErrorInvalidBillingCity: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_city")
      }
      /// Invalid billing country code
      internal static var paymentSdkErrorInvalidBillingCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_country_code")
      }
      /// Invalid billing email
      internal static var paymentSdkErrorInvalidBillingEmail: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_email")
      }
      /// Invalid billing full name
      internal static var paymentSdkErrorInvalidBillingFullName: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_full_name")
      }
      /// Invalid billing phone
      internal static var paymentSdkErrorInvalidBillingPhone: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_phone")
      }
      /// Invalid billing state
      internal static var paymentSdkErrorInvalidBillingState: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_state")
      }
      /// Invalid billing ZIP code
      internal static var paymentSdkErrorInvalidBillingZipCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_billing_zip_code")
      }
      /// Invalid Currency
      internal static var paymentSdkErrorInvalidCurrency: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_currency")
      }
      /// Invalid merchant country code (it should be alpha-2 ISO code)
      internal static var paymentSdkErrorInvalidMerchantCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_merchant_country_code")
      }
      /// Invalid shipping address
      internal static var paymentSdkErrorInvalidShippingAddress: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_address")
      }
      /// Invalid shipping city
      internal static var paymentSdkErrorInvalidShippingCity: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_city")
      }
      /// Invalid shipping country code
      internal static var paymentSdkErrorInvalidShippingCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_country_code")
      }
      /// Invalid shipping email
      internal static var paymentSdkErrorInvalidShippingEmail: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_email")
      }
      /// Invalid shipping full name
      internal static var paymentSdkErrorInvalidShippingFullName: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_full_name")
      }
      /// Invalid shipping phone number
      internal static var paymentSdkErrorInvalidShippingPhone: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_phone")
      }
      /// Invalid shipping state
      internal static var paymentSdkErrorInvalidShippingState: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_state")
      }
      /// Invalid shipping ZIP code
      internal static var paymentSdkErrorInvalidShippingZipCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_invalid_shipping_zip_code")
      }
      /// Please provide billing info
      internal static var paymentSdkErrorMissingBillingInfo: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_billing_info")
      }
      /// Cart description is empty!
      internal static var paymentSdkErrorMissingCartDescription: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_cart_description")
      }
      /// Cart ID is empty!
      internal static var paymentSdkErrorMissingCartId: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_cart_id")
      }
      /// Missing client key!
      internal static var paymentSdkErrorMissingClientKey: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_client_key")
      }
      /// Invalid config data
      internal static var paymentSdkErrorMissingConfigData: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_config_data")
      }
      /// Currency is empty!
      internal static var paymentSdkErrorMissingCurrency: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_currency")
      }
      /// Missing data
      internal static var paymentSdkErrorMissingDataTitle: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_data_title")
      }
      /// Missing merchant country code!
      internal static var paymentSdkErrorMissingMerchantCountryCode: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_merchant_country_code")
      }
      /// Profile ID is empty!
      internal static var paymentSdkErrorMissingProfileId: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_profile_id")
      }
      /// Invalid server IP
      internal static var paymentSdkErrorMissingServerIp: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_server_ip")
      }
      /// Missing server key!
      internal static var paymentSdkErrorMissingServerKey: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_server_key")
      }
      /// Please provide shipping info
      internal static var paymentSdkErrorMissingShippingInfo: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_shipping_info")
      }
      /// Token is missing
      internal static var paymentSdkErrorMissingTokenizationToken: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_tokenization_token")
      }
      /// Transaction reference is missing
      internal static var paymentSdkErrorMissingTransactionReference: String {
        return L10n.tr("Localizable", "payment_sdk_error_missing_transaction_reference")
      }
      /// Network error, please try again!
      internal static var paymentSdkErrorNetwork: String {
        return L10n.tr("Localizable", "payment_sdk_error_network")
      }
      /// Validation Error
      internal static var paymentSdkErrorValidationTitle: String {
        return L10n.tr("Localizable", "payment_sdk_error_validation_title")
      }
      /// No
      internal static var paymentSdkNo: String {
        return L10n.tr("Localizable", "payment_sdk_no")
      }
      /// Ok
      internal static var paymentSdkOk: String {
        return L10n.tr("Localizable", "payment_sdk_ok")
      }
      /// Powered By
      internal static var paymentSdkPoweredBy: String {
        return L10n.tr("Localizable", "payment_sdk_powered_by")
      }
      /// 3D Secure
      internal static var paymentSdkRedirectionTitle: String {
        return L10n.tr("Localizable", "payment_sdk_redirection_title")
      }
      /// SamsungPay token is empty
      internal static var paymentSdkSamsungPayErrorMissingToken: String {
        return L10n.tr("Localizable", "payment_sdk_samsung_pay_error_missing_token")
      }
      /// Save & Continue
      internal static var paymentSdkSaveContinue: String {
        return L10n.tr("Localizable", "payment_sdk_save_continue")
      }
      /// City
      internal static var paymentSdkShippingAddressCity: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_city")
      }
      /// Country
      internal static var paymentSdkShippingAddressCountry: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_country")
      }
      /// Email
      internal static var paymentSdkShippingAddressEmail: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_email")
      }
      /// Full Name
      internal static var paymentSdkShippingAddressFullName: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_full_name")
      }
      /// Phone Number
      internal static var paymentSdkShippingAddressPhone: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_phone")
      }
      /// State
      internal static var paymentSdkShippingAddressState: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_state")
      }
      /// Street
      internal static var paymentSdkShippingAddressStree: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_stree")
      }
      /// Zip Code
      internal static var paymentSdkShippingAddressZip: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_address_zip")
      }
      /// Shipping Details
      internal static var paymentSdkShippingDetails: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_details")
      }
      /// Select Country
      internal static var paymentSdkShippingSelectCountry: String {
        return L10n.tr("Localizable", "payment_sdk_shipping_select_country")
      }
      /// Yes
      internal static var paymentSdkYes: String {
        return L10n.tr("Localizable", "payment_sdk_yes")
      }

    internal enum QRCode {
        /// Scan the QR Code that appears in the mobile mockup in your dashboard to be able to view your app demo
        internal static var content: String {
          return L10n.tr("Localizable", "QRCode.content")
        }
        /// Scan Me
        internal static var scanMe: String {
          return L10n.tr("Localizable", "QRCode.scanMe")
        }
        /// Skip
        internal static var skip: String {
          return L10n.tr("Localizable", "QRCode.skip")
        }
        /// Scan QR Code
        internal static var title: String {
          return L10n.tr("Localizable", "QRCode.title")
        }
    }

    internal enum Cart {
        /// Add To Cart
        internal static var addToCart: String {
          return L10n.tr("Localizable", "cart.addToCart")
        }
        /// Add Wishlist
        internal static var addWishList: String {
          return L10n.tr("Localizable", "cart.addWishList")
        }
        /// Checkout
        internal static var checkout: String {
          return L10n.tr("Localizable", "cart.checkout")
        }
        /// SAR 
        internal static var currency: String {
          return L10n.tr("Localizable", "cart.currency")
        }
        /// Your Cart is Empty, start adding products
        internal static var emptyMessage: String {
          return L10n.tr("Localizable", "cart.emptyMessage")
        }
        /// Items
        internal static var items: String {
          return L10n.tr("Localizable", "cart.items")
        }
        /// Remove
        internal static var remove: String {
          return L10n.tr("Localizable", "cart.remove")
        }
        /// Remove Wishlist
        internal static var removeWishList: String {
          return L10n.tr("Localizable", "cart.removeWishList")
        }
        /// You saved
        internal static var saved: String {
          return L10n.tr("Localizable", "cart.saved")
        }
        /// Subtotal
        internal static var subtotal: String {
          return L10n.tr("Localizable", "cart.subtotal")
        }
        /// Cart
        internal static var title: String {
          return L10n.tr("Localizable", "cart.title")
        }
    }

    internal enum Categories {
        /// Categories
        internal static var title: String {
          return L10n.tr("Localizable", "categories.title")
        }
    }

    internal enum Checkout {
        /// Add New Address
        internal static var addNewAddress: String {
          return L10n.tr("Localizable", "checkout.addNewAddress")
        }
        /// Address
        internal static var address: String {
          return L10n.tr("Localizable", "checkout.address")
        }
        /// Addresses List
        internal static var addresses: String {
          return L10n.tr("Localizable", "checkout.addresses")
        }
        /// Area
        internal static var area: String {
          return L10n.tr("Localizable", "checkout.area")
        }
        /// Choose Area
        internal static var areaPlaceholder: String {
          return L10n.tr("Localizable", "checkout.areaPlaceholder")
        }
        /// Areas
        internal static var areas: String {
          return L10n.tr("Localizable", "checkout.areas")
        }
        /// Back to cart
        internal static var backToCart: String {
          return L10n.tr("Localizable", "checkout.backToCart")
        }
        /// Cash on delivery
        internal static var cashOnDelivery: String {
          return L10n.tr("Localizable", "checkout.cashOnDelivery")
        }
        /// change
        internal static var change: String {
          return L10n.tr("Localizable", "checkout.change")
        }
        /// Choose payment method
        internal static var choosePayment: String {
          return L10n.tr("Localizable", "checkout.choosePayment")
        }
        /// Cities
        internal static var cities: String {
          return L10n.tr("Localizable", "checkout.cities")
        }
        /// City
        internal static var city: String {
          return L10n.tr("Localizable", "checkout.city")
        }
        /// Choose City
        internal static var cityPlaceholder: String {
          return L10n.tr("Localizable", "checkout.cityPlaceholder")
        }
        /// Confirm
        internal static var confirm: String {
          return L10n.tr("Localizable", "checkout.confirm")
        }
        /// Contact Info
        internal static var contactInfo: String {
          return L10n.tr("Localizable", "checkout.contactInfo")
        }
        /// Continue
        internal static var `continue`: String {
          return L10n.tr("Localizable", "checkout.continue")
        }
        /// Countries
        internal static var countries: String {
          return L10n.tr("Localizable", "checkout.countries")
        }
        /// Country
        internal static var country: String {
          return L10n.tr("Localizable", "checkout.country")
        }
        /// Choose Country
        internal static var countryPlaceholder: String {
          return L10n.tr("Localizable", "checkout.countryPlaceholder")
        }
        /// Delivery
        internal static var delivery: String {
          return L10n.tr("Localizable", "checkout.delivery")
        }
        /// Delivery Info
        internal static var deliveryInfo: String {
          return L10n.tr("Localizable", "checkout.deliveryInfo")
        }
        /// Detailed Address
        internal static var detailedAddress: String {
          return L10n.tr("Localizable", "checkout.detailedAddress")
        }
        /// Write Your Detailed Address
        internal static var detailedAddressPlaceholder: String {
          return L10n.tr("Localizable", "checkout.detailedAddressPlaceholder")
        }
        /// Edit
        internal static var edit: String {
          return L10n.tr("Localizable", "checkout.edit")
        }
        /// Estimated VAT
        internal static var estimatedVat: String {
          return L10n.tr("Localizable", "checkout.estimatedVat")
        }
        /// Full Name
        internal static var fullName: String {
          return L10n.tr("Localizable", "checkout.fullName")
        }
        /// items
        internal static var items: String {
          return L10n.tr("Localizable", "checkout.items")
        }
        /// Mobile no.
        internal static var mobile: String {
          return L10n.tr("Localizable", "checkout.mobile")
        }
        /// Number
        internal static var number: String {
          return L10n.tr("Localizable", "checkout.Number")
        }
        /// Online Payement
        internal static var onlinePayement: String {
          return L10n.tr("Localizable", "checkout.onlinePayement")
        }
        /// Order Summery
        internal static var orderSummery: String {
          return L10n.tr("Localizable", "checkout.orderSummery")
        }
        /// Out Of Stock
        internal static var outOfStock: String {
          return L10n.tr("Localizable", "checkout.outOfStock")
        }
        /// Payment
        internal static var payment: String {
          return L10n.tr("Localizable", "checkout.payment")
        }
        /// Payment Method
        internal static var paymentMethod: String {
          return L10n.tr("Localizable", "checkout.paymentMethod")
        }
        /// Review
        internal static var review: String {
          return L10n.tr("Localizable", "checkout.review")
        }
        /// You have items run out of stock 
        internal static var runsOutOfStock: String {
          return L10n.tr("Localizable", "checkout.runsOutOfStock")
        }
        /// Shipping
        internal static var shipping: String {
          return L10n.tr("Localizable", "checkout.shipping")
        }
        /// Shipping Info
        internal static var shippingInfo: String {
          return L10n.tr("Localizable", "checkout.shippingInfo")
        }
        /// 1
        internal static var step1: String {
          return L10n.tr("Localizable", "checkout.step1")
        }
        /// 2
        internal static var step2: String {
          return L10n.tr("Localizable", "checkout.step2")
        }
        /// 3
        internal static var step3: String {
          return L10n.tr("Localizable", "checkout.step3")
        }
        /// Subtotal
        internal static var subtotal: String {
          return L10n.tr("Localizable", "checkout.subtotal")
        }
        /// Checkout
        internal static var title: String {
          return L10n.tr("Localizable", "checkout.title")
        }
        /// Total Amount
        internal static var totalAmount: String {
          return L10n.tr("Localizable", "checkout.totalAmount")
        }
        /// Update Address
        internal static var updateAddress: String {
          return L10n.tr("Localizable", "checkout.updateAddress")
        }
      internal enum Addresses {
          /// Set As Default
          internal static var setAsDefault: String {
            return L10n.tr("Localizable", "checkout.addresses.setAsDefault")
          }
      }
      internal enum Button {
          /// Continue
          internal static var `continue`: String {
            return L10n.tr("Localizable", "checkout.button.continue")
          }
      }
      internal enum Errors {
          /// Please Choose Your City First
          internal static var selectCityFirst: String {
            return L10n.tr("Localizable", "checkout.errors.selectCityFirst")
          }
          /// Please Choose Your Country First
          internal static var selectCountryFirst: String {
            return L10n.tr("Localizable", "checkout.errors.selectCountryFirst")
          }
      }
    }

    internal enum EmptyScreen {
        /// Please Login First
        internal static var loginFirst: String {
          return L10n.tr("Localizable", "emptyScreen.loginFirst")
        }
        /// No Data Found
        internal static var noData: String {
          return L10n.tr("Localizable", "emptyScreen.noData")
        }
        /// No Orders exist
        internal static var noOrders: String {
          return L10n.tr("Localizable", "emptyScreen.noOrders")
        }
      internal enum Button {
          /// Login
          internal static var login: String {
            return L10n.tr("Localizable", "emptyScreen.button.login")
          }
      }
    }

    internal enum ForceUpdate {
        /// You have to update Your version!
        internal static var message: String {
          return L10n.tr("Localizable", "forceUpdate.message")
        }
        /// New Version is Available!
        internal static var title: String {
          return L10n.tr("Localizable", "forceUpdate.title")
        }
      internal enum UpdateACtion {
          /// Update
          internal static var title: String {
            return L10n.tr("Localizable", "forceUpdate.updateACtion.title")
          }
      }
    }

    internal enum ForgetPassword {
        /// No worries! Enter your email address  below and we will send you a code to reset password.
        internal static var content: String {
          return L10n.tr("Localizable", "forget_password.content")
        }
        /// Email
        internal static var email: String {
          return L10n.tr("Localizable", "forget_password.email")
        }
        /// Forget Password
        internal static var title: String {
          return L10n.tr("Localizable", "forget_password.title")
        }
      internal enum Button {
          /// Send Reset Link
          internal static var sendReset: String {
            return L10n.tr("Localizable", "forget_password.button.sendReset")
          }
      }
    }

    internal enum Home {
        /// See all
        internal static var seeAll: String {
          return L10n.tr("Localizable", "home.seeAll")
        }
    }

    internal enum Login {
        /// Create an account
        internal static var createAccount: String {
          return L10n.tr("Localizable", "login.create_account")
        }
        /// Forget Password
        internal static var forgetPassword: String {
          return L10n.tr("Localizable", "login.forget_password")
        }
        /// Password
        internal static var password: String {
          return L10n.tr("Localizable", "login.password")
        }
        /// Incorrect password.
        internal static var passwordError: String {
          return L10n.tr("Localizable", "login.password_error")
        }
        /// Enter your password
        internal static var passwordPlaceholder: String {
          return L10n.tr("Localizable", "login.password_placeholder")
        }
        /// Mobile no
        internal static var phone: String {
          return L10n.tr("Localizable", "login.phone")
        }
        /// Incorrect phone.
        internal static var phoneError: String {
          return L10n.tr("Localizable", "login.phone_error")
        }
        /// Enter your mobile number
        internal static var phonePlaceholder: String {
          return L10n.tr("Localizable", "login.phone_placeholder")
        }
        ///  and 
        internal static var privacyAnd: String {
          return L10n.tr("Localizable", "login.privacyAnd")
        }
        /// Privacy Policy
        internal static var privacyLabel: String {
          return L10n.tr("Localizable", "login.privacyLabel")
        }
        /// By continuing, you agree to our
        internal static var privacyTitle: String {
          return L10n.tr("Localizable", "login.privacyTitle")
        }
        /// Skip
        internal static var skip: String {
          return L10n.tr("Localizable", "login.skip")
        }
        /// Terms of Service
        internal static var termsLabel: String {
          return L10n.tr("Localizable", "login.termsLabel")
        }
        /// Login
        internal static var title: String {
          return L10n.tr("Localizable", "login.title")
        }
    }

    internal enum Message {
      internal enum Error {
          /// Please enter a valid amount
          internal static var invalidAmount: String {
            return L10n.tr("Localizable", "message.error.invalidAmount")
          }
          /// Please choose your address
          internal static var selectDefaultAddress: String {
            return L10n.tr("Localizable", "message.error.selectDefaultAddress")
          }
          /// Error
          internal static var title: String {
            return L10n.tr("Localizable", "message.error.title")
          }
      }
      internal enum Success {
          /// Success
          internal static var title: String {
            return L10n.tr("Localizable", "message.success.title")
          }
      }
    }

    internal enum NetworkError {
        /// Check Your Internet Connection
        internal static var noInternet: String {
          return L10n.tr("Localizable", "networkError.noInternet")
        }
        /// Internal Server Error
        internal static var serverError: String {
          return L10n.tr("Localizable", "networkError.serverError")
        }
    }

    internal enum OrderDetails {
        /// Cancel Order
        internal static var cancelOrder: String {
          return L10n.tr("Localizable", "orderDetails.cancelOrder")
        }
        /// Order #
        internal static var orderNumber: String {
          return L10n.tr("Localizable", "orderDetails.orderNumber")
        }
    }

    internal enum Orders {
        /// Current
        internal static var current: String {
          return L10n.tr("Localizable", "orders.current")
        }
        /// Order 
        internal static var order: String {
          return L10n.tr("Localizable", "orders.order")
        }
        /// Past
        internal static var past: String {
          return L10n.tr("Localizable", "orders.past")
        }
        /// Placed On 
        internal static var placedOn: String {
          return L10n.tr("Localizable", "orders.placedOn")
        }
        /// Order History
        internal static var title: String {
          return L10n.tr("Localizable", "orders.title")
        }
        /// View Details
        internal static var viewDetails: String {
          return L10n.tr("Localizable", "orders.viewDetails")
        }
      internal enum Status {
          /// Arriving
          internal static var arriving: String {
            return L10n.tr("Localizable", "orders.status.arriving")
          }
          /// Delivered
          internal static var delivered: String {
            return L10n.tr("Localizable", "orders.status.delivered")
          }
          /// Pending
          internal static var pending: String {
            return L10n.tr("Localizable", "orders.status.pending")
          }
      }
    }

    internal enum Popups {
        /// Cancel
        internal static var cancel: String {
          return L10n.tr("Localizable", "popups.cancel")
        }
        /// Are you Sure You want to cancel  this order
        internal static var cancelOrderMsg: String {
          return L10n.tr("Localizable", "popups.cancelOrderMsg")
        }
        /// Confirm
        internal static var confirm: String {
          return L10n.tr("Localizable", "popups.confirm")
        }
        /// yes, Delete My Account
        internal static var confirmDeleteAccount: String {
          return L10n.tr("Localizable", "popups.confirmDeleteAccount")
        }
        /// Are you sure you want to delete your account?
        internal static var deleteAccount: String {
          return L10n.tr("Localizable", "popups.deleteAccount")
        }
        /// Login
        internal static var login: String {
          return L10n.tr("Localizable", "popups.login")
        }
        /// You don’t have an account please login first
        internal static var loginMsg: String {
          return L10n.tr("Localizable", "popups.loginMsg")
        }
        /// Logout
        internal static var logout: String {
          return L10n.tr("Localizable", "popups.logout")
        }
        /// Are you Sure you want to logout ?
        internal static var logoutMsg: String {
          return L10n.tr("Localizable", "popups.logoutMsg")
        }
    }

    internal enum ProductDetails {
        ///  SAR
        internal static var currency: String {
          return L10n.tr("Localizable", "productDetails.currency")
        }
        /// Quantity
        internal static var quantity: String {
          return L10n.tr("Localizable", "productDetails.quantity")
        }
        /// Qty
        internal static var quantityShort: String {
          return L10n.tr("Localizable", "productDetails.quantityShort")
        }
        /// More Details
        internal static var readMore: String {
          return L10n.tr("Localizable", "productDetails.readMore")
        }
    }

    internal enum Profile {
        /// Change Language
        internal static var changeLanguage: String {
          return L10n.tr("Localizable", "profile.changeLanguage")
        }
        /// Delete Account
        internal static var deleteAccount: String {
          return L10n.tr("Localizable", "profile.deleteAccount")
        }
        /// Edit Profile
        internal static var editProfile: String {
          return L10n.tr("Localizable", "profile.editProfile")
        }
        /// Guest
        internal static var guest: String {
          return L10n.tr("Localizable", "profile.guest")
        }
        /// Language
        internal static var language: String {
          return L10n.tr("Localizable", "profile.language")
        }
        /// logout
        internal static var logout: String {
          return L10n.tr("Localizable", "profile.logout")
        }
        /// Saved Addresses
        internal static var savedAddresses: String {
          return L10n.tr("Localizable", "profile.savedAddresses")
        }
        /// Settings
        internal static var settings: String {
          return L10n.tr("Localizable", "profile.settings")
        }
        /// Wishlist
        internal static var wishlist: String {
          return L10n.tr("Localizable", "profile.wishlist")
        }
      internal enum Update {
          /// Camera
          internal static var camera: String {
            return L10n.tr("Localizable", "profile.update.camera")
          }
          /// Cancel
          internal static var cancel: String {
            return L10n.tr("Localizable", "profile.update.cancel")
          }
          /// Choose Image
          internal static var chooseImage: String {
            return L10n.tr("Localizable", "profile.update.chooseImage")
          }
          /// Gallery
          internal static var gellary: String {
            return L10n.tr("Localizable", "profile.update.gellary")
          }
          /// Update Profile
          internal static var updateProfile: String {
            return L10n.tr("Localizable", "profile.update.updateProfile")
          }
      }
    }

    internal enum Register {
        /// Confirm Password
        internal static var confirmPassword: String {
          return L10n.tr("Localizable", "register.confirm_password")
        }
        /// Confirm your password
        internal static var confirmPasswordPlaceholder: String {
          return L10n.tr("Localizable", "register.confirm_password_placeholder")
        }
        /// Email
        internal static var email: String {
          return L10n.tr("Localizable", "register.email")
        }
        /// Enter your email
        internal static var emailPlaceholder: String {
          return L10n.tr("Localizable", "register.email_placeholder")
        }
        /// Name
        internal static var name: String {
          return L10n.tr("Localizable", "register.name")
        }
        /// Enter your name
        internal static var namePlaceholder: String {
          return L10n.tr("Localizable", "register.name_placeholder")
        }
        /// Password
        internal static var password: String {
          return L10n.tr("Localizable", "register.password")
        }
        /// Enter your password
        internal static var passwordPlaceholder: String {
          return L10n.tr("Localizable", "register.password_placeholder")
        }
        /// Mobile no
        internal static var phone: String {
          return L10n.tr("Localizable", "register.phone")
        }
        /// Enter your mobile number
        internal static var phonePlaceholder: String {
          return L10n.tr("Localizable", "register.phone_placeholder")
        }
        /// Register
        internal static var title: String {
          return L10n.tr("Localizable", "register.title")
        }
      internal enum Button {
          /// Create Account
          internal static var createAccount: String {
            return L10n.tr("Localizable", "register.button.create_account")
          }
      }
    }

    internal enum ResetPassword {
        /// Code
        internal static var code: String {
          return L10n.tr("Localizable", "reset_password.code")
        }
        /// Enter your code
        internal static var codePlaceholder: String {
          return L10n.tr("Localizable", "reset_password.codePlaceholder")
        }
        /// Confirm Password
        internal static var confirmPassword: String {
          return L10n.tr("Localizable", "reset_password.confirm_password")
        }
        /// Please enter and confirm your new password.\n You will need to login after you reset.
        internal static var content: String {
          return L10n.tr("Localizable", "reset_password.content")
        }
        /// Password
        internal static var password: String {
          return L10n.tr("Localizable", "reset_password.password")
        }
        /// Create New Password
        internal static var title: String {
          return L10n.tr("Localizable", "reset_password.title")
        }
      internal enum Button {
          /// Reset Password
          internal static var reset: String {
            return L10n.tr("Localizable", "reset_password.button.reset")
          }
      }
    }

    internal enum Tabbar {
        /// Cart
        internal static var cart: String {
          return L10n.tr("Localizable", "tabbar.cart")
        }
        /// Categories
        internal static var categories: String {
          return L10n.tr("Localizable", "tabbar.categories")
        }
        /// Home
        internal static var home: String {
          return L10n.tr("Localizable", "tabbar.home")
        }
        /// Orders
        internal static var orders: String {
          return L10n.tr("Localizable", "tabbar.orders")
        }
        /// Profile
        internal static var profile: String {
          return L10n.tr("Localizable", "tabbar.profile")
        }
    }

    internal enum Validation {
        /// Invalid email format
        internal static var invalidEmailFormate: String {
          return L10n.tr("Localizable", "validation.invalidEmailFormate")
        }
        /// Invalid Mobile Format
        internal static var invalidMobileNumber: String {
          return L10n.tr("Localizable", "validation.invalidMobileNumber")
        }
        /// Password must be more than 8 char, with one capital
        internal static var invalidPasswordFormate: String {
          return L10n.tr("Localizable", "validation.invalidPasswordFormate")
        }
        /// Password is not matched
        internal static var passwordNotMatch: String {
          return L10n.tr("Localizable", "validation.passwordNotMatch")
        }
        /// This field is required
        internal static var requiredField: String {
          return L10n.tr("Localizable", "validation.requiredField")
        }
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

//extension L10n {
//  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
//    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
//    return String(format: format, locale: Locale.current, arguments: args)
//  }
//}

private final class BundleToken {}
