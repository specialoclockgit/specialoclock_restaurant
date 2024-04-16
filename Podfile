# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Spacial OClock' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Spacial OClock
  
  pod 'IQKeyboardManagerSwift'
  pod 'Cosmos', '~> 23.0'
  pod 'FSCalendar'
  pod 'SKCountryPicker'
  pod 'SVPinView', '~> 1.0'
  pod 'SDWebImage'
  pod 'NVActivityIndicatorView'
  pod 'MBProgressHUD'
  pod 'GooglePlaces'
  pod 'SwiftGifOrigin'
  pod 'GoogleSignIn'
  pod 'FacebookLogin'
  pod 'SwiftMessages'
  pod 'DropDown'
  pod 'PhoneNumberKit'
  pod 'ShimmerSwift'
  pod 'SkeletonView'
  pod 'SwiftGifOrigin'
  pod 'GoogleMaps', '~> 3.7.0'
  pod 'Socket.IO-Client-Swift'
  pod 'SwiftyJSON'
  pod 'StripePaymentSheet'
  pod 'WaterfallLayout'
  pod 'QCropper'
  pod 'Instructions', '~> 2.2.0'
  pod 'SKPhotoBrowser'
  pod 'INSPhotoGallery'


  
    target 'Spacial OClockTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Spacial OClockUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
