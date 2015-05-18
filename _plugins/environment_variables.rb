# Plugin to add environment variables to the `site` object in Liquid templates

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      site.config['quayhost'] = ENV['QUAY_HOST'] || 'https://quay.io/'
    end
  end
end