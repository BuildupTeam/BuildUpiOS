# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# source 'https://github.com/CocoaPods/Specs.git'

def ui_pods
  pod 'MessageViewController'
  pod 'SwiftMessages'
  pod 'NVActivityIndicatorView/Extended'
  pod 'ViewAnimator'
  pod 'Windless', :git => 'https://github.com/Sob7y/Windless'
  pod 'PopupDialog'
  pod 'PanModal'
  pod 'Cosmos'
  pod 'PhoneNumberKit', '~> 3.1'
  pod 'CountryPickerView'
  pod 'SwiftKeychainWrapper'
  #pod 'UICircleProgressView'
  pod 'RangeSeekSlider'
  pod 'DPOTPView'
  pod "SCPageControl", :git => 'https://github.com/MahmoudNasserIbtikar/SCPageControl.git'
  pod 'lottie-ios'
  pod 'CarbonKit', :git => 'https://github.com/Sob7y/CarbonKit'
#  pod 'PagerTabStripView', '~> 3.2.0'
#  pod 'QRCodeReader.swift', '~> 10.1.0',
  pod 'PayTabsSDK', '~> 6.4.12'
end

def date_tools
  pod 'DateToolsSwift'
end

def googleMaps_pods
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GooglePlacesSearchController'
end

def firebase_pods
  pod 'Firebase', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :tag => '10.5.0'
  pod 'FirebaseDatabase', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :tag => '10.5.0'
  pod 'FirebaseMessaging', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :tag => '10.5.0'
  pod 'FirebaseAnalytics', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :tag => '10.5.0'
  pod 'FirebaseAuth', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :tag => '10.5.0'
end

def network_pods
  pod 'Moya'
  pod 'ObjectMapper'
#  pod 'SDWebImage'
#  pod 'SDWebImageSVGCoder'
end

def quality_pods
  pod 'SwiftLint', '~> 0.44.0'
end

def analytics_pods
  pod 'AppsFlyerFramework'
end

def media_players
  pod "youtube-ios-player-helper"
end

target 'BuildUp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for BuildUp
  
  ui_pods
  firebase_pods
  date_tools
  network_pods
  googleMaps_pods
  quality_pods
  media_players
  analytics_pods
  
  target 'BuildUpTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'BuildUpUITests' do
    # Pods for testing
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
