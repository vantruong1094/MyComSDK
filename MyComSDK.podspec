Pod::Spec.new do |s|

#
s.platform = :ios
s.ios.deployment_target = '13.0'
s.name = "MyComSDK"
s.summary = "MyComSDK"
s.requires_arc = true

#
s.version = "0.1.0"

#
s.license = { :type => "MIT", :file => "License.md" }

#  - Replace with your name and e-mail address
s.author = { "truongcv" => "vantruong1094@gmail.com" }

#  - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/vantruong1094/MyComSDK"

#  - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/vantruong1094/MyComSDK.git",
             :tag => "#{s.version}" }

s.source_files = "MyComSDK/Sources/**/*.swift"

s.dependency 'Alamofire', '~> 5.6.2'
s.dependency 'Moya', '~> 15.0.0'
s.dependency 'ReactiveSwift', '~> 6.7.0'
s.dependency 'RxSwift', '~> 6.5.0'

s.swift_version = "5.0"

end
