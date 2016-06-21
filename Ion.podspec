#
# Be sure to run `pod lib lint Ion.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Ion"
  s.version          = "0.6.2"
  s.summary          = "A short description of Ion."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
						Form creation for iOS apps has never been easier. Simply create your form object,
						wire it to your views and have access to a myriad of functionality available such as
						form verification, form state changes notification, the form data ready to be sent 
						on a backend using Alamofire and much more.
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/Ion"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "George Kaimakas" => "gkaimakas@gmail.com" }
  s.source           = { :git => "https://github.com/gkaimakas/Ion.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Ion' => ['Pod/Assets/*.png']
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'UIKit'
  s.dependency 'SwiftValidators', '~> 2.2.0'
end
