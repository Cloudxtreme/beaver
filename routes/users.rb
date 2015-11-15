
require 'sinatra/base'
require 'rack'
require 'bcrypt'
require 'sinatra/json'
require_relative '../models/user.rb'

class UsersController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'
  
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      auth = User.where(login: username).first
      true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
    end

  get '/' do
    User.all.select("id, login").to_json
  end

  post '/' do
    @request_payload = JSON.parse request.body.read
    @user = User.new(login: @request_payload['login'], password: @request_payload['password'])
      if @user.save
        json status: 200
      else
        json status: 400
      end
   end

  patch '/:id' do
    @request_payload = JSON.parse request.body.read
    @user = User.find(params[:id])
    if @user.update_attributes(@request_payload)
      json status: 200
    else
      json status: 400
    end
  end

  delete '/:id' do
    @user = User.find(params[:id])
    if @user.destroy
      json status: 200
    else
      json status: 400
    end
  end
end
