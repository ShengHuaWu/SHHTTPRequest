Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.name         = "SHHTTPRequest"
  s.version      = "0.0.2"
  s.summary      = "Send http requests synchronously or asynchronously."
  s.description  = "This library is used to send http requests synchronously or asynchronously.
                    For now, it only supports get, post, put and delete methods."
  s.homepage     = "https://github.com/ShengHuaWu/SHHTTPRequest"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.author             = { "ShengHua Wu" => "fantasy0404@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.platform     = :ios, "7.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #s

  s.source       = { :git => "https://github.com/ShengHuaWu/SHHTTPRequest.git", :tag => "#{s.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.source_files  = "SHHTTPRequest/Class/*.{h,m}", "SHHTTPRequest/Category/*.{h,m}"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.requires_arc = true

end
