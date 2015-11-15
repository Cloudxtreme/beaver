require 'sinatra/base'
#routes
require_relative './routes/users.rb'
require_relative './routes/templates.rb'
require_relative './routes/template_types.rb'
require_relative './routes/host_configs.rb'
require_relative './routes/operating_systems.rb'
require_relative './routes/provisions.rb'

require_relative './beaver_api'

map('/') { run BeaverApp}
map('/users') { run UsersController }
map('/templates') { run TemplatesController }
map('/templatetypes') { run TemplateTypesController }
map('/hostconfigs') { run HostConfigsController }
map('/operatingsystems') { run OperatingSystemsController }
map('/provisions') { run ProvisionsController }
