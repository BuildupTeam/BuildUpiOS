# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def ui_pods
  pod 'MessageViewController'
  pod 'SwiftMessages'
  pod 'NVActivityIndicatorView/Extended'
  pod 'ViewAnimator'
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.2.0'
  pod 'Windless', :git => 'https://github.com/Sob7y/Windless'
  pod 'PopupDialog'
  pod 'PanModal'
  pod 'Cosmos'
  
  pod 'PhoneNumberKit', '~> 3.1'
  pod 'CountryPickerView'
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.2.0'
  pod 'SwiftKeychainWrapper'
  pod 'UICircleProgressView'
  pod 'RangeSeekSlider'
  pod 'DPOTPView'
end

def date_tools
  pod 'DateToolsSwift'
end

def googleMaps_pods
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GooglePlacesSearchController'
end

def network_pods
  pod 'Moya'
  pod 'ObjectMapper'
  pod 'SDWebImage'
  pod 'SDWebImageSVGCoder'
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
