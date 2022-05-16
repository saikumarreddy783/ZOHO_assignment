# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ZOHO Notes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZOHO Notes
  
  pod 'SkyFloatingLabelTextField'
  pod 'SVProgressHUD'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'BonsaiController'
  pod 'FRHyperLabel'
  pod "TTGSnackbar"
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


