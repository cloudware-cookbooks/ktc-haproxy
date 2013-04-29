maintainer        "KT Cloudware, Inc."
description       "Wrapper cookbook for rcb's haproxy cookbook"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.6"

%w{ centos ubuntu }.each do |os|
  supports os
end

%w{ osops-utils haproxy }.each do |dep|
  depends dep
end
