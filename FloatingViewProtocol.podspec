Pod::Spec.new do |s|
  s.name         = "FloatingViewProtocol"
  s.version      = "0.0.2"
  s.summary      = "A protocol make your view floating and draggable"
  s.homepage     = "https://github.com/Natai/FloatingViewProtocol"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "natai" => "" }
  s.platform     = :ios, "8.0"
  s.swift_version = "4.2"
  s.source       = { :git => "https://github.com/Natai/FloatingViewProtocol.git", :tag => "#{s.version}" }
  s.source_files = "Source/*.swift"
end