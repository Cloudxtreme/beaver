
require 'sinatra/base'
require 'rack'
require 'bcrypt'
require 'sinatra/json'
require_relative '../models/operating_system.rb'

class OperatingSystemsController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      auth = User.where(login: username).first
      true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
    end

  get '/' do
    OperatingSystem.all.to_json
  end

  get '/:id' do
    json OperatingSystem.find(params[:id])
  end

  post '/' do
    @request_payload = JSON.parse request.body.read
    @os = OperatingSystem.new(name: @request_payload['name'],
                                                            major: @request_payload['major'],
                                                            minor: @request_payload['minor'],
                                                            url: @request_payload['url'])
      if @os.save
        json status: 200
      else
        json status: 400
      end
   end

  patch '/:id' do
    @request_payload = JSON.parse request.body.read
    @os = OperatingSystem.find(params[:id])
    if @os.update_attributes(@request_payload)
      json status: 200
    else
      json status: 400
    end
  end

  delete '/:id' do
    @os = OperatingSystem.find(params[:id])
    if @os.destroy
      json status: 200
    else
      json status: 400
    end
  end
end
