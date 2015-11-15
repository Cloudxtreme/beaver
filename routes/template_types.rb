require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/json'
require_relative '../models/template_type.rb'

class TemplateTypesController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    auth = User.where(login: username).first
    true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
  end

  get('/') {json TemplateType.all.select('id,name')}
end
