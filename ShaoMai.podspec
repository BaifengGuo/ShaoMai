
Pod::Spec.new do |s|

s.name       = "ShaoMai"
s.version     = "0.0.3"
s.summary     = "ShaoMai"
s.description   = <<-DESC
我就是测试，你可以仔细看看我的内容
DESC
s.homepage     = "https://github.com/BaifengGuo/ShaoMai.git"
# s.screenshots   = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license     = 'MIT'
s.author      = { "“BaifengGuo”" => "“641257850@qq.com”" }
s.source       = { :git => "https://github.com/BaifengGuo/ShaoMai.git", :tag => "#{s.version}" }


s.platform   = :ios, '4.3'
# s.ios.deployment_target = '5.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true

s.source_files  = "ShaoMai/ShaoMai/Core/*.{h,m}"
s.exclude_files = "Classes/Exclude" #排除不需要的文件
# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'


end

