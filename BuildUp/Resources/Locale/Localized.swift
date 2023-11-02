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
        /// Scan QR Code
        internal static var title: String {
          return L10n.tr("Localizable", "QRCode.title")
        }
    }

    internal enum EmptyScreen {
        /// No Data Found
        internal static var noData: String {
          return L10n.tr("Localizable", "emptyScreen.noData")
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
