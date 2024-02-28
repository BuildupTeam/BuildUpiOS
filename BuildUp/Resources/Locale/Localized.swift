//Localized.swift

import Foundation

// swiftlint:disable superfluous_disable_command 
// swiftlint:disable file_length
// swiftlint:disable trailing_whitespace trailing_newline

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

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
