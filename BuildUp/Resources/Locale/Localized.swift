//Localized.swift

import Foundation

// swiftlint:disable superfluous_disable_command 
// swiftlint:disable file_length
// swiftlint:disable trailing_whitespace trailing_newline

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

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
        /// Readmore
        internal static var readMore: String {
          return L10n.tr("Localizable", "productDetails.readMore")
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
