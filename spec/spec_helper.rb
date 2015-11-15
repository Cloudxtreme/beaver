ENV['RACK_ENV'] = 'development'

require 'rack/test'
require_relative '../beaver_api.rb'
require_relative '../routes/users.rb'
require_relative '../routes/templates.rb'
require_relative '../routes/template_types.rb'

include Rack::Test::Methods

def app
  BeaverApp
end
