#
# Be sure to run `pod lib lint KAAlert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KAAlert'
  s.version          = '0.1.1'
  s.summary          = 'A short description of KAAlert.'
  s.swift_version    = '5.0'
  s.platform         = :ios
  s.summary = '????? ????'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This is an add-on to the many rows that are in the Eureka Community. This row will allow users to select a video from there library to export to a backend service of there choosing.

                       DESC

  s.homepage         = 'https://github.com/KhorenAs/KAAlert'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KhorenAs' => 'khorenasatryan13@gmail.com' }
  s.source           = { :git => 'https://github.com/KhorenAs/KAAlert.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'KAAlert/Classes/**/*'
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'KAAlert' => ['KAAlert/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
end

