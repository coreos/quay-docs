FROM ubuntu:latest

# Install dependencies
RUN apt-get update # 20JULY2015
RUN apt-get -y install ruby ruby-dev make nodejs python python-dev python-pip
RUN pip install pygments
RUN gem install jekyll --no-rdoc --no-ri
RUN gem install pygments.rb --no-rdoc --no-ri

# Setup jekyll app
RUN mkdir -p /docs
WORKDIR /docs
COPY _config.yml _config.yml
COPY _includes _includes/
COPY _layouts _layouts/
COPY _plugins _plugins/
COPY api api/
COPY glossary glossary/
COPY guides guides/
COPY images images/
COPY index.html index.html
COPY issues issues/
COPY javascripts javascripts/
COPY params.json params.json
COPY solution solution
COPY stylesheets stylesheets/

# Set runtime options
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
