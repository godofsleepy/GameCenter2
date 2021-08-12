# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

use_frameworks!

workspace 'GameCenter2'

target 'GameCenter2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	pod 'SDWebImageSwiftUI', '~> 1.5.0'
	pod 'SwiftLint', '~> 0.40.0'
	pod 'RealmSwift', '~> 10.1.4'
	pod 'Alamofire', '~> 5.2'

  # Pods for GameCenter2

end

target 'Core' do
project 'Core/Core'
	pod 'RealmSwift', '~> 10.1.4'
end

target 'Game' do
project 'Game/Game'
  use_frameworks!
	pod 'Alamofire', '~> 5.2'
	pod 'RealmSwift', '~> 10.1.4'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
