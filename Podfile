# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AlamaFire' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AlamaFire

	pod 'Alamofire', '~> 4.8'
pod 'DropDown'
 pod 'Socket.IO-Client-Swift'
pod "GCDWebServer", "~> 3.0"
pod 'Http.swift', '~> 2.2.0'


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

end
