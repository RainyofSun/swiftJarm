target 'YukTunai' do
  
   use_frameworks!
  

  pod 'SnapKit'

  pod 'Masonry'

  pod 'Alamofire'

  pod 'SDWebImage'

  pod 'MJRefresh'
  
  pod 'SmartCodable'
  
  pod 'FMDB'
  
  pod 'SVProgressHUD'
  
  pod 'IQKeyboardManagerSwift'

  pod 'FBSDKCoreKit'
  pod 'BRPickerView/Default','2.9.1'
end


post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
