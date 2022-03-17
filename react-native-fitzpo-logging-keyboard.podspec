# react-native-fitzpo-logging-keyboard.podspec

require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-fitzpo-logging-keyboard"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-fitzpo-logging-keyboard
                   DESC
  s.homepage     = "https://github.com/github_account/react-native-fitzpo-logging-keyboard"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/github_account/react-native-fitzpo-logging-keyboard.git", :tag => "#{s.version}" }
  s.resource_bundles = {
    'Resources' => ['ios/**/*.xcassets']
  }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end

