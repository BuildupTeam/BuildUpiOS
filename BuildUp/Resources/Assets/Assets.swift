// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let icEyeOff = ImageAsset(name: "ic_eye-off")
  internal static let icInfo = ImageAsset(name: "ic_info")
  internal static let registerArrowDown = ImageAsset(name: "register_arrow_down")
  internal static let bannerType1Placeholder = ImageAsset(name: "banner_type1_placeholder")
  internal static let bannerType3Placeholder = ImageAsset(name: "banner_type3_placeholder")
  internal static let icCartArrowDown = ImageAsset(name: "ic_cart_arrow_down")
  internal static let icCartFav = ImageAsset(name: "ic_cart_fav")
  internal static let icCartTrash = ImageAsset(name: "ic_cart_trash")
  internal static let icMinusGray = ImageAsset(name: "ic_minus_gray")
  internal static let icMinusWhite = ImageAsset(name: "ic_minus_white")
  internal static let icCartWhite = ImageAsset(name: "ic_cart_white")
  internal static let imgPlaceholder = ImageAsset(name: "img_placeholder")
  internal static let icApplePayLogo = ImageAsset(name: "ic_Apple_Pay_logo")
  internal static let icCheckCircle = ImageAsset(name: "ic_checkCircle")
  internal static let icComplete = ImageAsset(name: "ic_complete")
  internal static let icCreditCard = ImageAsset(name: "ic_credit-card")
  internal static let icPayOnline = ImageAsset(name: "ic_pay_online")
  internal static let icPlusCircle = ImageAsset(name: "ic_plus_circle")
  internal static let icNotifications = ImageAsset(name: "ic_notifications")
  internal static let icSearch = ImageAsset(name: "ic_search")
  internal static let icSquadio = ImageAsset(name: "ic_squadio")
  internal static let navBackButton = ImageAsset(name: "nav_back_button")
  internal static let icArrowLeft = ImageAsset(name: "ic_arrow_left")
  internal static let add = ImageAsset(name: "add")
  internal static let addProductSpecification = ImageAsset(name: "add_product_specification")
  internal static let arrowDown = ImageAsset(name: "arrow_down")
  internal static let arrowDownBlack = ImageAsset(name: "arrow_down_black")
  internal static let arrowRight = ImageAsset(name: "arrow_right")
  internal static let plusWhite = ImageAsset(name: "plus_white")
  internal static let productDetailsCart = ImageAsset(name: "product_details_cart")
  internal static let productDetailsFav = ImageAsset(name: "product_details_fav")
  internal static let productDetailsShare = ImageAsset(name: "product_details_share")
  internal static let remove = ImageAsset(name: "remove")
  internal static let addToCart = ImageAsset(name: "Add_to_cart")
  internal static let icPlaceholderProduct = ImageAsset(name: "ic_Placeholder_product")
  internal static let productAddtoCart = ImageAsset(name: "product_addtoCart")
  internal static let productAddtoCartWhite = ImageAsset(name: "product_addtoCart_white")
  internal static let productFavorite = ImageAsset(name: "product_favorite")
  internal static let productUnFavorite = ImageAsset(name: "product_unFavorite")
  internal static let icAvatar = ImageAsset(name: "ic_avatar")
  internal static let icCamera = ImageAsset(name: "ic_camera")
  internal static let icCemeraCover = ImageAsset(name: "ic_cemera_cover")
  internal static let icProfileAccount = ImageAsset(name: "ic_profile_account")
  internal static let icProfileArrow = ImageAsset(name: "ic_profile_arrow")
  internal static let icProfileCover = ImageAsset(name: "ic_profile_cover")
  internal static let icProfileHeart = ImageAsset(name: "ic_profile_heart")
  internal static let icProfileLogout = ImageAsset(name: "ic_profile_logout")
  internal static let icProfileSetting = ImageAsset(name: "ic_profile_setting")
  internal static let icSavedAddresses = ImageAsset(name: "ic_saved_addresses")
  internal static let qrCode1 = ImageAsset(name: "QR Code-1")
  internal static let qrCode = ImageAsset(name: "QR_code")
  internal static let splash = ImageAsset(name: "Splash")
  internal static let icCartActive = ImageAsset(name: "ic_cart_active")
  internal static let icCartInactive = ImageAsset(name: "ic_cart_inactive")
  internal static let icCategoriesActive = ImageAsset(name: "ic_categories_active")
  internal static let icCategoriesInactive = ImageAsset(name: "ic_categories_inactive")
  internal static let icHomeActive = ImageAsset(name: "ic_home_active")
  internal static let icHomeInactive = ImageAsset(name: "ic_home_inactive")
  internal static let icProfileActive = ImageAsset(name: "ic_profile_active")
  internal static let icProfileInactive = ImageAsset(name: "ic_profile_inactive")
  internal static let icSettingsActive = ImageAsset(name: "ic_settings_active")
  internal static let icSettingsInactive = ImageAsset(name: "ic_settings_inactive")
  internal static let productImage = ImageAsset(name: "productImage")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
