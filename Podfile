source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'smallday_test' do
    pod 'Alamofire', '~> 4.0'
    pod 'SwiftyJSON'
    pod 'YYModel'
    pod 'YYCategories'
    pod 'SDWebImage', '~>3.8'
    pod 'MJRefresh'
    pod 'ReactiveCocoa', :git => 'https://github.com/ReactiveCocoa/ReactiveCocoa.git'
    pod 'SDCycleScrollView','~> 1.64'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end