name "application_static"
maintainer "allnightlong"
maintainer_email "allnightlong@allnightlong.ru"
license "Apache 2.0"
description "Installs/Configures application_static"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "0.1.0"

depends "application"
depends "nginx"

suggests "git"
suggests "mercurial"
