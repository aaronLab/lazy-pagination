platform :ios, '12.0'
inhibit_all_warnings!

target 'LazyPagination' do

  use_frameworks!

  pod 'Then'
  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end