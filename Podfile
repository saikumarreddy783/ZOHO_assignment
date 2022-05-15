# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ZOHO Notes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZOHO Notes
  pod 'Firebase/Crashlytics'
  pod 'ImageSlideshow'
  pod 'FreshchatSDK'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'DropDown'
  pod 'SkyFloatingLabelTextField'
  pod 'ReachabilitySwift'
  pod 'SVProgressHUD'
  pod 'MBProgressHUD'
  pod 'FBSDKLoginKit', '11.0.0'
  pod 'IQKeyboardManager'
  pod 'Alamofire', '5.4.1'
  pod 'SwiftyJSON'
  pod 'SDWebImage'
  pod 'MarqueeLabel'
  pod 'GoogleSignIn', '5.0.2'
  pod "ExpandableLabel"
  pod "ImageSlideshow/SDWebImage"
  pod 'BonsaiController'
  pod 'FRHyperLabel'
  pod "TTGSnackbar"
  pod 'RangeSeekSlider'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Crashlytics'
  pod 'Fabric'
  pod 'SDWebImageWebPCoder'
  pod 'Kingfisher'
  pod 'PINRemoteImage', '~> 3.0.0-beta'
  pod 'SkeletonView'

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

end


