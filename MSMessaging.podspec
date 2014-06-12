Pod::Spec.new do |s|
  s.name         = "MSMessaging"
  s.version      = "0.0.2"
  s.summary      = "An example on how to reproduce the gradient chat bubbles as seen on Messages for iOS 7"
  s.description  = "An example on how to reproduce the gradient chat bubbles as seen on Messages for iOS 7."
  s.homepage     = "https://github.com/mstultz/MSMessaging"
  s.license      = "MIT"
  s.author       = "Mark Stultz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/mstultz/MSMessaging.git", :tag => "0.0.2" }
  s.source_files  = "MSMessaging/*.{h,m}"
  s.resources = "MSMessaging/*.xcassets"
  s.requires_arc = true
end
