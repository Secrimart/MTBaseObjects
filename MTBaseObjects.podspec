#
# Be sure to run `pod lib lint MTBaseObjects.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTBaseObjects'
  s.version          = '0.1.11'
  s.summary          = 'Define a set of foundational objects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Define a set of foundational objects, that can be used build to a simple project.
                       DESC

  s.homepage         = 'https://github.com/Secrimart/MTBaseObjects'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'secrimart@aliyun.com' => 'secrimart@aliyun.com' }
  s.source           = { :git => 'https://github.com/Secrimart/MTBaseObjects.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MTBaseObjects/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MTBaseObjects' => ['MTBaseObjects/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.2'
  s.dependency 'MBProgressHUD', '~> 1.1'
  s.dependency 'Masonry', '~> 1.1'
  s.dependency 'BackButtonHandler', '~> 1.0'
  s.dependency 'SDWebImage', '~> 4.3'

  s.dependency 'MTFramework', '~> 0.1'

end
