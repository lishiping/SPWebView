Pod::Spec.new do |s|

  s.name         = "SPWebView"
  s.version      = "0.0.2"
  s.summary      = "WeChat WebView component,JS To OC,微信浏览器WebView,简化JS与OC互相调用及传递数据的方式"
  s.homepage     = "https://github.com/lishiping/SPWebView.git"
  s.license      = "LICENSE"
  s.author       = { "lishiping" => "83118274@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/lishiping/SPWebView.git",
                     :tag => s.version}

  s.source_files = 'SPWebView/LSP/SPWebView/Core/*.{h,m,mm,cpp,c}',
                   'SPWebView/LSP/SPWebView/Progress/*/*.{h,m,mm,cpp,c}'

  s.public_header_files = 'SPWebView/LSP/SPWebView/Core/*.h',
                          'SPWebView/LSP/SPWebView/Progress/*/*.h'
 
  s.resources = "SPWebView/LSP/SPWebView/Resource/SPWebView.bundle"

  s.frameworks = 'WebKit', 'JavaScriptCore'

  s.requires_arc = true

end
