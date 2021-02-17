# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'GameCenter2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	pod 'SDWebImageSwiftUI', '~> 1.5.0'
	pod 'SwiftLint', '~> 0.40.0'
	pod 'RealmSwift'
	pod 'Alamofire', '~> 5.2'

  # Pods for GameCenter2

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
