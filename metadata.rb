name "application_static"
maintainer "allnightlong"
maintainer_email "allnightlong@allnightlong.ru"
license "Apache 2.0"
description "Simple chef cookbook to quick host static web sites with nginx."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "0.3.0"

depends "application"
depends "nginx"

suggests "git"

supports 'ubuntu'
