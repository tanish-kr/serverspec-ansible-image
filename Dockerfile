FROM centos:6
MAINTAINER tatsunori nishikori <tora.1986.tatsu@gmail.com>
RUN yum update -y

# install dependency
RUN yum install -y git tar gcc openssl-devel epel-release \
  libyaml-devel readline-devel zlib-devel \
  libffi-devel libxml2-devel libxslt-devel

# install ruby
RUN curl -O http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
RUN tar xvzf ruby-2.2.2.tar.gz -C /usr/local/share
RUN cd /usr/local/share/ruby-2.2.2 && ./configure && make && make install
RUN echo "gem: --no-rdoc --no-ri" >> $HOME/.gemrc

# install rake & serverspec
RUN gem install bundler && gem install serverspec

# install ansible
RUN yum install -y ansible
