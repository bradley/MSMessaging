#
#  Be sure to run `pod spec lint MSMessaging.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "MSMessaging"
  s.version      = "0.0.1"
  s.summary      = "An example on how to reproduce the gradient chat bubbles as seen on Messages for iOS 7"
  s.description  = "An example on how to reproduce the gradient chat bubbles as seen on Messages for iOS 7."
  s.homepage     = "https://github.com/mstultz/MSMessaging"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = "Mark Stultz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/mstultz/MSMessaging.git", :tag => "0.0.1" }
  s.source_files  = "MSMessaging/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  s.resources = "MSMessaging/*.xcassets"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
