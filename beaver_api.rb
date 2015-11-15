require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'json'
require 'thin'
require 'bcrypt'
require 'ostruct'
require 'rdiscount'

require_relative './models/provision.rb'

#libs
#require_relative './lib/config.rb'

class BeaverApp < Sinatra::Base

  set :database_file, "./config/database.yml"

  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'


  get ('/') {json response: "Beaver - Augello Christophe" }

  get '/ks=:uuid' do
    content_type 'text/plain'
    erb Provision.where(uuid: params[:uuid]).first.content
  end

  get '/help' do
    markdown :help
  end

  private

end
