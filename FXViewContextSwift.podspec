Pod::Spec.new do |s|
  s.name         = "FXViewContextSwift"
  s.version      = "1.0.1"
  s.summary      = "FX视图展示框架"

  s.homepage     = "https://github.com/zqw87699/FXViewContextSwift"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXViewContextSwift.git", :tag => "#{s.version}"}

  s.platform     = :ios, "8.0"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXViewContextSwift'

  s.requires_arc = true

s.subspec 'API' do |api|
    api.source_files = 'Classes/API/*.{swift}'
end

s.subspec 'Core' do |core|
    core.source_files = 'Classes/Core/*.{swift}'
    core.dependency 'SnapKit', '3.2.0'
    core.dependency 'ReactiveSwift','1.1.1'
end

s.subspec 'Extension' do |extension|
    extension.source_files = 'Classes/Extension/*.{swift}'
    extension.dependency 'FXCommonSwift/Base'
end

end
