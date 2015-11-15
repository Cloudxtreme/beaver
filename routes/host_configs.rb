
require 'sinatra/base'
require 'rack'
require 'bcrypt'
require 'sinatra/json'
require 'ostruct'
require_relative '../models/host_config.rb'

class HostConfigsController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      auth = User.where(login: username).first
      true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
    end

  get '/' do
    HostConfig.all.select("id, name").to_json
  end

  get  '/:id' do
    HostConfig.find(params[:id]).settings
  end

  post '/' do
    @request_payload = JSON.parse request.body.read
    @hostconfig = HostConfig.new(name: @request_payload['name'], settings: @request_payload['settings'])
      if @hostconfig.save
        json status: 200
        else
        json status: 400
      end
   end

  patch '/:id' do
    @request_payload = JSON.parse request.body.read
    @hostconfig = HostConfig.find(params[:id])
    if @hostconfig.update_attributes(@request_payload)
      json status: 200
    else
      json status: 400
    end
  end

  delete '/:id' do
    @hostconfig = HostConfig.find(params[:id])
    if @hostconfig.destroy
      json status: 200
    else
      json status: 400
    end
  end
end
