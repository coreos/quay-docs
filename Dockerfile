FROM ubuntu:latest

# Install dependencies
RUN apt-get update # 14MAY2015
RUN apt-get -y install ruby ruby-dev make nodejs python python-dev python-pip
RUN pip install pygments
RUN gem install jekyll --no-rdoc --no-ri
RUN gem install pygments.rb --no-rdoc --no-ri

# Setup jekyll app
RUN mkdir -p /docs
WORKDIR /docs
ADD _config.yml _config.yml
ADD _includes _includes/
ADD _layouts _layouts/
ADD _plugins _plugins/
ADD api api/
ADD glossary glossary/
ADD guides guides/
ADD images images/
ADD index.html index.html
ADD issues issues/
ADD javascripts javascripts/
ADD params.json params.json
ADD solution solution
ADD stylesheets stylesheets/

# Set runtime options
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
