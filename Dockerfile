FROM ubuntu:latest

RUN apt-get update # 14MAY2015
RUN apt-get -y install ruby ruby-dev make nodejs
RUN gem install jekyll --no-rdoc --no-ri

RUN mkdir -p /docs
WORKDIR /docs
ADD _config.yml _config.yml
ADD _includes _includes/
ADD _layouts _layouts/
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

EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
