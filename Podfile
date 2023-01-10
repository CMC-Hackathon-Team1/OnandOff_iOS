# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'OnandOff' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OnandOff
	pod 'SnapKit', '~> 5.0.0'
	pod 'Then'
	pod 'FSCalendar'
        pod 'KakaoSDK'
        pod 'GoogleSignIn'
        post_install do |installer|
            installer.pods_project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
                end
            end
       end
    end
