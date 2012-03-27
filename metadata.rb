maintainer        "David Marble"
maintainer_email  "davidmarble@gmail.com"
license           "Apache 2.0"
name              "supervisor"
description       "supervisor recipes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe            "supervisor", ""
    
%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end