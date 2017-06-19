Pod::Spec.new do |s|

  s.name         = "SPWebView"
  s.version      = "0.0.13"
  s.summary      = "WeChat WebView component,JS To OC,微信浏览器WebView,简化JS与OC互相调用及传递数据的方式"
  s.homepage     = "https://github.com/lishiping/SPWebView.git"
  s.license      = "LICENSE"
  s.author       = { "lishiping" => "83118274@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/lishiping/SPWebView.git",
                     :tag => s.version, :submodules => true}

  #s.source_files = 'SPWebView/SPWebView/Core/*.{h,m,mm,cpp,c}',
                   'SPWebView/SPWebView/Progress/*.{h,m,mm,cpp,c}'

  #s.public_header_files = 'SPWebView/SPWebView/Core/*.h',
                          'SPWebView/SPWebView/Progress/*.h'
 
   s.frameworks = 'WebKit', 'JavaScriptCore'

   #s.default_subspecs = "Core","Progress"
   s.default_subspecs = "Core"

   #s.subspec 'Progress' do |p|
   #p.source_files = "SPWebView/SPWebView/Progress/*.{h,m,mm,cpp,c}"
   #p.public_header_files = 'SPWebView/SPWebView/Progress/*.h'
   #end

   s.subspec 'Core' do |c|
   #c.dependency     "SPWebView/Progress"
   c.dependency 'NJKWebViewProgress',           '0.2.3' 
   c.source_files = "SPWebView/SPWebView/Core/*.{h,m,mm,cpp,c}"
   c.public_header_files = 'SPWebView/SPWebView/Core/*.h'
   end  

  s.resources = "SPWebView/SPWebView/Resource/SPWebView.bundle"

  s.requires_arc = true

end
