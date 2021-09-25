

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'
RspecApiDocumentation.configure do |config|
  config.format = [:api_blueprint] # use your own favourite format
  config.request_headers_to_include = ['Content-Type', 'X-Access-Token'] # replace X-Access-Token with your Authorization header.
  config.response_headers_to_include = ['Content-Type']
  config.api_name = 'schoolb' # replace with your app name
end